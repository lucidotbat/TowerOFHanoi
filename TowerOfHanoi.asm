# Luis Fernando Ramírez Ramos, 744615
# José Andrés Nacarro Ozuna, 744889

# Organización Y Arquitectura de Computadoras
# Práctica 1, Torres de Hanoi

.text
	addi s0, zero, 3		# n, numero de discos
	
	lui s1, 0x10010			# torre origen, apuntador a la primera posicion de la memoria RAM
	slli t0, s0, 2			# offset de (n x 4) para alacenar las 3 torres en memoria
	add s2, t0, s1			# torre auxiliar
	add s3, t0, s2			# torre destino 
	
	addi t1, zero, 1		# variable para hacer la comparacion n == 1
	addi t2, zero, 1		# i para simular un ciclo for

for:	blt s0, t2, break		# s0 < t1 (n < i), esta condicion no se va a cumplir al principio, 
					# adentro del ciclo se va a inicializar la torre origen y se va a 
					# ampliar el tamanio de las torres dependiendo de n
	sw t2, 0(s1)
	addi t2, t2, 1			# i++
	addi s1, s1, 4			# aumentamos tamanio de la torre origen
	addi s2, s2, 4			# aumentamos tamanio de la torre auxiliar
	addi s3, s3, 4			# aumentamos tamanio de la torre destino
	jal for
	
break:	sub s1, s1, t0			# continuacion del codigo al salir del ciclo for
	jal hanoi			# se ejecuta la funcion que acomoda los discos
	jal ending			# una vez que termina la funcion hanoi, saltamos al final del codigo
	
hanoi:	beq s0, t1, if			# s0 == t1 (n == 1), cuando n sea mayor a 1, se hace un salto a la
					# etiqueta if, cuando llegue a 1, continua en la siguiente linea
					# para dar fin a la funcion y a la recursion
	addi sp, sp, -8			# restamos 8 al stack pointer para almacenar 4 en s0(n) y 4 en ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	addi s0, s0, -1			# n = n - 1
	
	add s4, zero, s2		# s4 sera un "auxiliar" para poder hacer el cambio 
	add s2, zero, s3		# entre la torre auxiliar y la torre destino
	add s3, zero, s4
	
	jal hanoi			# volvemos a llamar la funcion hanoi
	
	add s5, zero, s2		# s5 sera otro "auxiliar" para hacer un nuevo swap	
	add s2, zero, s3		# entre la torre auxiliar y la torre destino
	add s3, zero, s5
	
	lw ra, 0(sp)			# cargamos los valores de s0(n) y ra
	lw s0, 4(sp)
	
	addi sp, sp, 8			# ahora hacemos la suma de 8 al sp por los pasos anteriores
	
	sw zero, 0(s1) 			# pop
	addi s1, s1, 4 			# sumar 4 a la torre para realocarnos al nuevo punto mas alto de la torre
	addi s3, s3, -4 		# restar 4 para aumentar el tamaño y poder hacer el push del nuevo valor
	sw s0, 0(s3)   			# push
	
	addi sp, sp, -8			# guardamos s0(n) y ra como habiamos hecho antes
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	addi s0, s0, -1			# n = n -1
	
	add s6, zero, s2		# s6 sera otro "auxiliar" para hacer un nuevo swap
	add s2, zero, s1		# entre la torre origen y la torre auxiliar
	add s1, zero, s6
	
	jal hanoi			# volvemos a llamar la funcion hanoi
	
	add s7, zero, s2		# s7 sera otro "auxiliar" para hacer un nuevo swap
	add s2, zero, s1		# entre la torre destino y la torre auxiliar
	add s1, zero, s7
	
	lw ra, 0(sp)			# cargamos los valores de s0(n) y ra
	lw s0, 4(sp)
	
	addi sp, sp, 8			# hacemos la suma correspondiente de 8 al sp
	
	jalr ra				# saltamos a la siguiente linea despued de haber llamado
					# la funcion hanoi

if:	sw zero, 0(s1) 			# pop
	addi s1, s1, 4  		# sumar 4 a la torre para realocarnos al nuevo punto mas alto de la torre
	addi s3, s3, -4 		# restar 4 para aumentar el tamaño y poder hacer el push del nuevo valor
	sw s0, 0(s3)   			# push
	
	jalr ra 			# saltamos a la siguiente linea despued de haber llamado
					# la funcion hanoi
	
ending:	nop				# fin del programa
