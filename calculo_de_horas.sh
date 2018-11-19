#!/bin/bash

#-----------------------------------------------------------------------------------------------------
#
# Versão:			1.0
# Arquivo:			calculo_de_horas.sh - Soma ou subtrai horas
# Escrito por:		Maurício G. Paiva
# E-mail:			mauricimgp@gmail.com
# S.O:				Debian GNU/Linux 8.11
# Path do Projeto:	https://github.com/mauriciodez/calculo_de_horas.git
# Licença : 		GPLv3
#
#-----------------------------------------------------------------------------------------------------

# Função de escolha "adição" ou "subtração"
OP_OPTION ()	{

k=0
	while [ $k -eq 0 ]; do
		echo -e "Você quer somar ou subtrair ?\tsoma [1] || subtração [2]"
			read op
				if [ $op -eq 1 -o $op -eq 2 ];then
					k=1
				else
					clear
						echo "opção inválida, tente de novo !!! para continuar [enter]"
							read
				fi
		clear
	done

			}
# Função de Entrada manual de horas.
ENT_HOR ()	{

tti=0
i=0
	while [ $i -eq 0 ];do

		read -p "Insira a hora `[[ $tti = 0 ]] && echo "Inicial"||echo "Final"`. [ hhh:mm:ss ] => " ent

# Testa o formato horas "hh:mm:ss", se válido converte horas e minuto para segundos.
					if echo $ent | egrep -q '^([0-9]{2,})[:|.]([0-5][0-9]):([0-5][0-9])$';then
						hh=$(( 10#`echo $ent | awk -F':' '{print $1}'` * 3600 ))
						mm=$(( 10#`echo $ent | awk -F':' '{print $2}'` * 60 ))
						ss=$(( 10#`echo $ent | awk -F':' '{print $3}'` * 1 ))

# Testa a posição de entrada. '0' para hora inicial  //  seta valores para variávels, hora inicial (hi)
# e hora final (hf) // soma segundos
							if [ $tti -eq 0 ] ; then
								hi=$ent
								tti=$(( $hh + $mm + $ss ))
							else
								hf=$ent
								ttf=$(( $hh + $mm + $ss ))
								i=1
							fi
					else
						echo "Hora Inválida"
					fi
	done

			}
# Função que converte segundos para minutos e horas
SEG_HOR ()	{

	hhf=$(( $tt / 3600 ))
	mmf=$(( ( $tt - $hhf * 3600 ) / 60 ))
	ssf=$(( $tt - $hhf * 3600 -$mmf * 60  ))
	sinal="+ "
			}

# Função inversa que converte segundos para minutos e horas

SEG_HOR_INV () {

	htt=$(( $ttf - $tti ))

		if [ $htt -gt -3600 ];then
			hhf=0
		else
			hhf=$(( $htt / -3600 ))
		fi

			if [ $htt -gt -60 ];then
				mmf=0
			else
				mmf=$(( ( $htt +  $hhf * 3600 ) / -60 ))
			fi

				ssf=$(( $htt * -1 - $hhf * 3600 - $mmf * 60 ))

					sinal="- "

				}

OP_HORAS ()	{

# Testa se a operação é "adição" ou "subtração"
	if [ $op -eq 1 ]; then
		tt=$(echo $(( $ttf + $tti )))
		SEG_HOR
	else
		if [ $ttf -gt $tti ];then
			tt=$(echo $(( $ttf - $tti )))
			SEG_HOR
		else
			SEG_HOR_INV
		fi
	fi
			}
# Função para formatar dois digitos
FORMATA () {
 if [ $hhf -lt 10 ];then
	hhf=`echo "0$hhf"`

		if [ $mmf -lt 10 ];then
			mmf=`echo "0$mmf"`

				if [ $ssf -lt 10 ];then
					ssf=`echo "0$ssf"`
				fi
		fi
fi
clear
			}

clear
echo -e "Calculadora de horas\n"
	OP_OPTION
		ENT_HOR
			OP_HORAS
				FORMATA

				echo -e "Hora Inicial => $hi\t\tHora Final => $hf\n"
					echo "$sinal$hhf:$mmf:$ssf"