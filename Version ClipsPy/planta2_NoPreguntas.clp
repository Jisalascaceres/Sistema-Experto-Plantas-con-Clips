
(deftemplate planta
 (slot temp );
 (slot nombre);
 (slot trepadora);si o no
 (slot flores_liguladas) ; si o no
 (slot hojas_forma); ovadas o palmatifidas
 (slot perenne); si o no
 (slot pelos_glandulares);si o no
 (slot Pancholargo);si o no
 (slot tam_flor);grande o peque�o
 (slot tipo_hoja);pinnadas o basales
 (slot corimbos);diploide o hexaploide
 (slot hojas_inferiores);pinnadas o lobuladas
 (slot hojas_amplitud);anchas o estrechas
 (slot hojas_superiores); pinnadas o enteras
 (slot link);link a la imagen
)

(deffacts Base
	(planta 
		(temp "no")
		(nombre "Delairea_odorata")
		(trepadora "si")	
		(flores_liguladas "no")
		(link "img/Delairea_odorata.jpg")
	)
	
	(planta 
 		(temp "no")	
		(nombre "Senecio_angulatus")
		(trepadora "si")
		(flores_liguladas "si")
		(hojas_forma "ovadas")
		(link "img/Senecio_angulatus.jpg")

	)
	(planta 
		(temp "no")		
 		(nombre "Senecio_tamoides")
		(trepadora "si")
		(flores_liguladas "si")
		(hojas_forma "palmatifidas")
		(link "img/Senecio_tamoides.jpg")
	)
	(planta 
		(temp "no")		
 		(nombre "Senecio_bollei")
		(trepadora "no")
		(perenne "si")
		(link "img/Senecio_bollei.jpg")
	)
	(planta 
		(temp "no")		
 		(nombre "Senecio_viscosus")
		(trepadora "no")
		(perenne "no")
		(pelos_glandulares "si")
		(link "img/Senecio_flavus.jpg")
	)
	(planta
	(temp "no")
	(nombre "Senecio_flavus")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "si")
	(link "img/Senecio_flavus.jpg")
	
	)
	(planta
	(temp "no")
	(nombre "Senecio_massaicus")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "no")
	(tam_flor "no")
	(tipo_hoja "pinnadas")
	(link "img/Senecio_massaicus.jpg")
	
	
	)
	(planta
	(temp "no")
	(nombre "Senecio_vulgaris")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "no")
	(tam_flor "no")
	(tipo_hoja "basales")
	(corimbos "diploide")
	(link "img/Senecio_vulgare.jpg")
	
	
	)
	(planta
	(temp "no")
	(nombre "Senecio_teneriffae")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "no")
	(tam_flor "no")
	(tipo_hoja "basales")
	(corimbos "hexaploide")
	(link "img/Senecio_flavus.jpg")
	
	)
	(planta
	(temp "no")
	(nombre "Senecio_leucanthemifolium")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "no")
	(tam_flor "si")
	(hojas_inferiores "no")
	(hojas_amplitud "anchas")
	(link "img/leucanthemifolium.jpg")
	
	)
	(planta
	(temp "no")
	(nombre "Senecio_ilsae")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "no")
	(tam_flor "si")
	(hojas_inferiores "no")
	(hojas_amplitud "estrechas")
	(link "img/Senecio_ilsae.jpg")
	
	)
	(planta
	(temp "no")
	(nombre "Senecio_incrassatus")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "no")
	(tam_flor "si")
	(hojas_inferiores "si")
	(hojas_superiores "pinnadas")
	(link "img/incrassatus.jpg")
	
	)
	(planta
	(temp "no")
	(nombre "Senecio_glaucus")	
	(trepadora "no")
	(perenne "no")
	(pelos_glandulares "no")
	(Pancholargo "no")
	(tam_flor "si")
	(hojas_inferiores "si")
	(hojas_superiores "enteras")
	(link "img/Senecio_glaucus.jpg")
	
	)
)

;---------------------------------------
; Programa experto para plantas del genero Senecio en Canarias.	
;Funcionamiento:
	; Tenemos todas las especies conocidas con sus caracteristicas definidas
	; El funcionamiento es, ir descendiendo por el arbol respondiendo preguntas hasta que nos encontremos un nodo final, estos estan se�alados porque crean el fact "final si"
	; Cuando el fact final si existe, veremos la planta que hemos creado a base de responder por el arbol y miraremos si hay alguno que coincida exactamente con el.
	; Este paso final lo hacemos con una regla que tiene la maxima prioridad.
	; La planta que creamos nosotros viene marcada por el slot "temp" la unica con el valor si es la que creemos.
;-----------------------------------------



;*********************
;RULES
;*********************

;el salience de cada pregunta indica en donde estamos en el arbol.


(defrule END (declare(salience 1000))
	(final si)
	(planta(temp "si") (trepadora ?t)(flores_liguladas ?fl)(hojas_forma ?hf)(perenne ?pn)(pelos_glandulares ?pg)(Pancholargo ?pal)(tam_flor ?tf)(tipo_hoja ?th)(corimbos ?c)(hojas_amplitud ?ha)(hojas_superiores ?hs)(hojas_inferiores ?hi))
	(planta(temp "no")(nombre ?nb)(trepadora ?tb)(flores_liguladas ?flb)(hojas_forma ?hfb)(perenne ?pnb)(pelos_glandulares ?pgb)(Pancholargo ?palb)(tam_flor ?tfb)(tipo_hoja ?thb)(corimbos ?cb)(hojas_amplitud ?hab)(hojas_superiores ?hsb)(hojas_inferiores ?hib)(link ?lb))
	;And de que todas las caracteristicas sean iguales.
	(test(and(eq ?t ?tb)(eq ?fl ?flb)(eq ?hf ?hfb)(eq ?pn ?pnb)(eq ?pg ?pgb)(eq ?pal ?palb)(eq ?tf ?tfb)(eq ?th ?thb)(eq ?c ?cb)(eq ?ha ?hab)(eq ?hs ?hsb)(eq ?hi ?hib)))
	?p <-(planta(temp "si"))
	=>
	(modify ?p(temp "no"))
	(assert (path ?lb)) ; Declaramos el path para en el script de python tener el link a la imagen de la planta.
	(printout t "El nombre de la planta es: " ?nb crlf)
)



(defrule error
	(final si)
	(planta(temp "si") (trepadora ?t)(flores_liguladas ?fl)(hojas_forma ?hf)(perenne ?pn)(pelos_glandulares ?pg)(Pancholargo ?pal)(tam_flor ?tf)(tipo_hoja ?th)(corimbos ?c)(hojas_amplitud ?ha)(hojas_superiores ?hs)(hojas_inferiores ?hi))
	(planta(temp "no")(nombre ?nb)(trepadora ?tb)(flores_liguladas ?flb)(hojas_forma ?hfb)(perenne ?pnb)(pelos_glandulares ?pgb)(Pancholargo ?palb)(tam_flor ?tfb)(tipo_hoja ?thb)(corimbos ?cb)(hojas_amplitud ?hab)(hojas_superiores ?hsb)(hojas_inferiores ?hib))
	(not(test(and(eq ?t ?tb)(eq ?fl ?flb)(eq ?hf ?hfb)(eq ?pn ?pnb)(eq ?pg ?pgb)(eq ?pal ?palb)(eq ?tf ?tfb)(eq ?th ?thb)(eq ?c ?cb)(eq ?ha ?hab)(eq ?hs ?hsb)(eq ?hi ?hib))))
	?p <-(planta(temp "si"))
	=>
	(retract ?p)
	(printout t "No se ha encontrado ninguna planta con esas caracteristicas, por favor escriba solo las opciones dadas como respuesta." crlf)
	(assert(error si))
)

