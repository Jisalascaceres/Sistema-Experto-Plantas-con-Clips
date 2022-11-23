

# Programa realizado por: José Ignacio Salas Cáceres.

import cv2 
import logging
import clips
logging.basicConfig(level=10, format='%(message)s')
env = clips.Environment()
router = clips.LoggingRouter()
env.add_router(router)
env.load("Clips/planta2_NoPreguntas.clp")
env.reset() 


#Vamos a definir un diccionario donde mas vamos a almacenar los facts de la planta en cuestion
facts = {   'temp': None, 
            'nombre': None,
            'trepadora': None,
            'flores_liguladas': None,
            'hojas_forma': None,
            'perenne': None,
            'pelos_glandulares': None,
            'Pancholargo': None,
            'tam_flor': None,
            'tipo_hoja': None,
            'corimbos': None,
            'hojas_inferiores': None,
            'hojas_amplitud': None,
            'hojas_superiores': None
      }
   
    
#Vamos a definir tambien un diccionario que contenta los enunciados de las preguntas que vamos a hacerle al usuario..
preguntas = {  
        1:"1. La planta es trepadora?:(si o no)",
        2:"2. Las flores son liguladas?:(si o no)",
        3:"3. Las hojas son ovadas o palmatifidas?:(ovadas o palmatifidas)",
        4:"4. La planta es perenne?:(si o no)",
        5:"5. La planta tiene pelos glandulares?:(si o no)",
        6:"6. Las hojas son tan anchas como largas con flores flosculosas?: (si o no)",
        7:"7. Tiene flores liguladas mas grandes de 5x0.4 mm?:(si o no)",
        8:"8. Las hojas son pinnadas o basales?:(pinnadas o basales)",
        9: "9. Los corimbos son diploides o hexaploides?:(diploide o hexaploide)",
        10:"10. Las hojas inferiores estan estrechamente pinnadas?:(si o no)",
        11:"11. Las hojas son anchas o estrechas?:(anchas o estrechas)",
        12:"12. Las hojas superiores son pinnadas o enteras?:(pinnadas o enteras)"                              
} 
#Vamos a definir un diccionario que sirva como enlace entre el numero de la pregunta y el nombre del slot.
link={
    1: 'trepadora',
    2: 'flores_liguladas',
    3: 'hojas_forma',
    4: 'perenne',
    5: 'pelos_glandulares',
    6: 'Pancholargo',
    7: 'tam_flor',
    8: 'tipo_hoja',
    9: 'corimbos',
    10: 'hojas_inferiores',
    11: 'hojas_amplitud',
    12: 'hojas_superiores'
}

#Definimos las funciones

#vamos a definir una funcion que resetee el diccionario facts y presente un mensaje de error para que el usuario vuelva a empezar.
def reset_facts():
    for key in facts:
        facts[key] = None
    print("Error por favor escriba solo las opciones dadas como respuesta, quiere volver a empezar?:(si o no)")
    resp = input()
    if resp != 'si': #Cualquier respuesta que no sea si, finaliza el programa.
        exit()
        
#Esta funcion escribe la pregunta del numero que le insertemos y la almacena en el diccionario facts.
def ask_questions(key):
    print(preguntas[key])
    facts[link[key]] = input()


#Esta funcion se encarga de realizar el assert con el final y finaliza el programa.
def fin():
    env.assert_string('(final si)')
    assert_planta()
    env.run()
    show_image()
    exit()
    
#Esta funcion recoge el link de la imagen de la planta en los facts y la muestra.

def show_image():
    for fact in env.facts(): # Buscamos en la base de conocimiento el link de la imagen de la planta.
        if fact.template.name == 'path':
            path = "Clips/"+ (fact[0])
    image = cv2.imread(path)
    cv2.imshow('Plantita', image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    
    
    
    
    
#Esta funcion encuentra la template planta del clips e realiza el assert de los facts que hemos almacenado en el diccionario facts.
def assert_planta():
    planta = env.find_template('planta')
    
    Base = planta.assert_fact(temp = "si", 
                              trepadora = facts['trepadora'],
                              flores_liguladas = facts['flores_liguladas'],
                              hojas_forma = facts['hojas_forma'],
                              perenne = facts['perenne'], 
                              pelos_glandulares = facts['pelos_glandulares'],
                              Pancholargo = facts['Pancholargo'],
                              tam_flor = facts['tam_flor'], 
                              tipo_hoja = facts['tipo_hoja'], 
                              corimbos = facts['corimbos'], 
                              hojas_inferiores = facts['hojas_inferiores'],
                              hojas_amplitud = facts['hojas_amplitud'],
                              hojas_superiores = facts['hojas_superiores'])


# Empezamos a preguntar desde el principio, cambiando las preguntas que van despues segun la respuesta acorde con el arbol de decision.
while(True):
    ask_questions(1)
    if facts['trepadora'] == 'si':
        ask_questions(2)
        if facts['flores_liguladas'] == 'si':
            ask_questions(3)
            fin()
        if facts['flores_liguladas'] == 'no':
            fin()
    if facts['trepadora'] == 'no':
        ask_questions(4)
        if facts['perenne'] == 'si':
            fin()
        if facts['perenne'] == 'no':
            ask_questions(5)
            if facts['pelos_glandulares'] == 'si':
                fin()
            if facts['pelos_glandulares'] == 'no':
                ask_questions(6)
                if facts['Pancholargo'] == 'si':
                    fin()
                if facts['Pancholargo'] == 'no':
                    ask_questions(7)
                    if facts['tam_flor'] == 'no':
                        ask_questions(8)
                        if facts['tipo_hoja'] == 'pinnadas':
                            fin()
                        if facts['tipo_hoja'] == 'basales':
                            ask_questions(9)
                            if facts['corimbos'] == 'diploide':
                                fin()
                            if facts['corimbos'] == 'hexaploide':
                                fin()
                    if facts['tam_flor'] == 'si':
                        ask_questions(10)
                        if facts['hojas_inferiores'] == 'no':
                            ask_questions(11)
                            fin()
                        if facts['hojas_inferiores'] == 'si':
                            ask_questions(12)
                            fin()
    reset_facts() #Si el usuario no ha escrito una respuesta correcta, se resetean los facts y se pregunta si quiere volver a empezar.


