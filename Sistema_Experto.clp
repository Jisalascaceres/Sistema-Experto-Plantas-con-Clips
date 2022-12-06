
; Realizado por: José Ignacio Salas Cáceres.
;---------------------------------------
; Programa experto para plantas del genero Senecio en Canarias.	
;Funcionamiento:
; Lo primero que hemos hecho es definir la template de las plantas con todas las caracteristicas de las que vamos a preguntar y temp.
	; El slot temp, representa a la planta que estamos creando en base a los facts que preguntamos. Entonces, todas las plantas de la base de datos, tendran sus propiedades.
	; y ademas el slot temp en no. La planta que creamos nosotros es temp si.
	; Definidos los facts, definimos las reglas.
	; Hay dos tipos de reglas: Las de recopilar informacion, que corresponden a las preguntas que vamos haciendo en el arbol. 
	; Y la regla END, que es la que comparará nustra planta Temp si con las de la base de datos y nos devolverá el nombre de la que coincide.
	; Est�n definidos los niveles de salience representando el nivel del arbol en el que nos encontramos. 
	; Esto, aunque pueda parecer innecesario, hace falta ya que al modificar un hecho, cuenta como un nuevo hecho completamente

;-----------------------------------------


(deftemplate planta
 (slot temp);
 (slot nombre);
 (slot trepadora);si o no
 (slot flores_liguladas) ; si o no
 (slot hojas_forma); ovadas o palmatifidas
 (slot perenne); si o no
 (slot pelos_glandulares);si o no
 (slot Pancho/largo);si o no
 (slot tam_flor);si o no
 (slot tipo_hoja);pinnadas o basales
 (slot corimbos);diploide o hexaploide
 (slot hojas_inferiores);si o no
 (slot hojas_amplitud);anchas o estrechas
 (slot hojas_superiores); pinnadas o enteras
)
; Vamos a insertar todas las plantas que puede identificar el sistema.
(deffacts Base
	(planta 
		(temp no)
		(nombre Delairea_odorata)
		(trepadora si)	
		(flores_liguladas no)
	)
	
	(planta 
 		(temp no)	
		(nombre Senecio_angulatus)
		(trepadora si)
		(flores_liguladas si)
		(hojas_forma ovadas)

	)


	(planta 
		(temp no)		
 		(nombre Senecio_tamoides)
		(trepadora si)
		(flores_liguladas si)
		(hojas_forma palmatifidas)
	)


	(planta 
		(temp no)		
 		(nombre Senecio_bollei)
		(trepadora no)
		(perenne si)
		
	)


	(planta 
		(temp no)		
 		(nombre Senecio_viscosus)
		(trepadora no)
		(perenne no)
		(pelos_glandulares si)
	)


	(planta
	(temp no)
	(nombre Senecio_flavus)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo si)
	)


	(planta
	(temp no)
	(nombre Senecio_massaicus)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo no)
	(tam_flor no)
	(tipo_hoja pinnadas)
	)


	(planta
	(temp no)
	(nombre Senecio_vulgaris)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo no)
	(tam_flor no)
	(tipo_hoja basales)
	(corimbos diploides)
	)


	(planta
	(temp no)
	(nombre Senecio_teneriffae)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo no)
	(tam_flor no)
	(tipo_hoja basales)
	(corimbos hexaploides)
	)


	(planta
	(temp no)
	(nombre Senecio_leucanthemifolium)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo no)
	(tam_flor si)
	(hojas_inferiores no)
	(hojas_amplitud anchas)
	)

	
	(planta
	(temp no)
	(nombre Senecio_ilsae)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo no)
	(tam_flor si)
	(hojas_inferiores no)
	(hojas_amplitud estrechas)
	)


	(planta
	(temp no)
	(nombre Senecio_incrassatus)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo no)
	(tam_flor si)
	(hojas_inferiores si)
	(hojas_superiores pinnadas)
	)


	(planta
	(temp no)
	(nombre Senecio_incrassatus)	
	(trepadora no)
	(perenne no)
	(pelos_glandulares no)
	(Pancho/largo no)
	(tam_flor si)
	(hojas_inferiores si)
	(hojas_superiores enteras)
	)
)




;*********************
;RULES
;*********************

;el salience de cada pregunta indica en donde estamos en el arbol. De nuevo, no es necesario.


(defrule END (declare(salience 1000))
	(final si)
	(planta(temp si) (trepadora ?t)(flores_liguladas ?fl)(hojas_forma ?hf)(perenne ?pn)(pelos_glandulares ?pg)(Pancho/largo ?pal)(tam_flor ?tf)(tipo_hoja ?th)(corimbos ?c)(hojas_amplitud ?ha)(hojas_superiores ?hs)(hojas_inferiores ?hi))
	(planta(temp no)(nombre ?nb)(trepadora ?tb)(flores_liguladas ?flb)(hojas_forma ?hfb)(perenne ?pnb)(pelos_glandulares ?pgb)(Pancho/largo ?palb)(tam_flor ?tfb)(tipo_hoja ?thb)(corimbos ?cb)(hojas_amplitud ?hab)(hojas_superiores ?hsb)(hojas_inferiores ?hib))
	;And de que todas las caracteristicas sean iguales, si no se han establecido, serán iguales, porque seran None, nil en caso del clips.
	(test(and(eq ?t ?tb)(eq ?fl ?flb)(eq ?hf ?hfb)(eq ?pn ?pnb)(eq ?pg ?pgb)(eq ?pal ?palb)(eq ?tf ?tfb)(eq ?th ?thb)(eq ?c ?cb)(eq ?ha ?hab)(eq ?hs ?hsb)(eq ?hi ?hib)))
	?p <-(planta(temp si))
	=>
	(modify ?p(temp no))
	(printout t "El nombre de la planta es: " ?nb crlf)
)

(defrule Preguntas(declare(salience 1))
	
	=>
	(printout t "1. La planta es trepadora?:(si o no)")
	(bind ?resp (read))
	(assert (planta (temp si)(trepadora ?resp)))
	
)

(defrule TreparSi(declare(salience 2))
 	?p <-(planta(temp si) (trepadora si))
	=>
	(printout t "2. Tiene las flores liguladas?:(si o no)")
	(bind ?resp(read))
	(modify ?p(flores_liguladas ?resp))
	
)

(defrule FLNo(declare(salience 3))
 	(planta(temp si) (trepadora si)(flores_liguladas no))
	=>
	(assert (final si))
)
(defrule FLSi (declare(salience 3))
 	?p <-(planta(temp si) (trepadora si)(flores_liguladas si))
	=>
 	(printout t "3. Tiene las hojas ovadas o palmatifidas?:")
	(bind ?resp(read))
	(modify ?p(hojas_forma ?resp))
	(assert(final si))
)

(defrule TreparNo (declare(salience 2))
	 ?p <-(planta(temp si) (trepadora no))
	=>
	(printout t "4. Es la planta perennne?: (si o no)")
	(bind ?resp(read))
	(modify ?p(perenne ?resp))
)

(defrule Peresi(declare(salience 3))
	 ?p <-(planta(temp si) (trepadora no)(perenne si))
	=>
	(assert (final si))
)

(defrule PereNo (declare(salience 3))
	 ?p <-(planta(temp si) (trepadora no)(perenne no))
	=>
	(printout t "5. Tiene pelos glandulares?: (si o no)")
	(bind ?resp(read))
	(modify ?p(pelos_glandulares ?resp))
)

(defrule Pelossi(declare(salience 4))
	 ?p <-(planta(temp si) (trepadora no)(perenne no)(pelos_glandulares si))
	=>
	(assert (final si))
)

(defrule Pelono (declare(salience 4))
	 ?p <-(planta(temp si) (trepadora no)(perenne no)(pelos_glandulares no))
	=>
	(printout t "6. Las hojas son tan anchas como largas con flores flosculosas?: (si o no)")
	(bind ?resp(read))
	(modify ?p(Pancho/largo ?resp))
)

(defrule PanchoSi (declare(salience 5))
 ?p <-(planta(temp si) (Pancho/largo si))
 =>
 (assert(final si))
)

(defrule PanchoNo (declare(salience 5))
	 ?p <-(planta(temp si) (trepadora no)(perenne no)(Pancho/largo no))
	=>
	(printout t "7. Tiene flores liguladas mas grandes de 5x0.4 mm?:(si o no)")
	(bind ?resp(read))
	(modify ?p(tam_flor ?resp))
)

(defrule TamFlorNo (declare(salience 6))
	 ?p <-(planta(temp si) (trepadora no)(perenne no)(tam_flor no))
	=>
	(printout t "8. Las hojas son pinnadas o basales?:")
	(bind ?resp(read))
	(modify ?p(tipo_hoja ?resp))
)
(defrule TipHojaP (declare(salience 7))

(planta(temp si) (trepadora no)(perenne no)(tam_flor no)(tipo_hoja pinnadas))
=>
(assert(final si))
)
(defrule TipHojaB (declare(salience 7))

	?p <-(planta(temp si)(tipo_hoja basales))
	=>
	(printout t "9. Los corimbos son diploides o hexaploides?:")
	(bind ?resp(read))
	(modify ?p(corimbos ?resp))
	(assert (final si))

)
(defrule TamFlorSi (declare(salience 6))
	 ?p <-(planta(temp si) (trepadora no)(perenne no)(tam_flor si))
	=>
	(printout t "10. Las hojas inferiores son estrechamente pinnadas?: (si o no)")
	(bind ?resp(read))
	(modify ?p(hojas_inferiores ?resp))
)

(defrule TipHojaNo (declare(salience 7))
	 ?p <-(planta(temp si) (trepadora no)(perenne no)(hojas_inferiores no))
	=>
	(printout t "11. Las hojas son estrechas o anchas?:")
	(bind ?resp(read))
	(modify ?p(hojas_amplitud ?resp))
	(assert (final si))
)

(defrule TipHojaSi (declare(salience 7))
	 ?p <-(planta(temp si) (trepadora no)(perenne no)(hojas_inferiores si))
	=>
	(printout t "12. Las hojas superiores tambien pinnadas o enteras?:")
	(bind ?resp(read))
	(modify ?p(hojas_superiores ?resp))
	(assert (final si))
)