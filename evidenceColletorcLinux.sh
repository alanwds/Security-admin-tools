#!/bin/bash
# Script to collect evidences from compromised system (Linux)
# Script para coleta de evidencias e indicios de invasao em sistemas Linux
# Autor: Alan Santos - alanwds@gmail.com
# Data: 20/07/2012
# 1.1 - Revisao (by fmotta at uoldiveo dot com) - 08/08/2012
# 1.2 - Ajustes - alanwds - 10/09/2012

# Variaveis
DEBUGLOG="/tmp/debug.log"

# Iniciando a coleta de informacoes
/bin/echo "5 - Coletando informacoes"
/bin/echo "5.1 - Data e Hora"
/bin/echo "5.1 - Data e Hora" >> ${DEBUGLOG}
/bin/date >> ${DEBUGLOG}

/bin/echo "5.1 - Informacoes do sistema"
/bin/echo "5.1 - Informacoes do sistema" >> ${DEBUGLOG}
/bin/uname –a >> ${DEBUGLOG}

/bin/echo "5.2 - Portas abertas"
/bin/echo "5.2 - Portas abertas" >> ${DEBUGLOG}
/bin/netstat –an | grep LISTEN >> ${DEBUGLOG}

/bin/echo "5.3 - Arquivos abertos"
/bin/echo "5.3 - Arquivos abertos" >> ${DEBUGLOG}
/usr/sbin/lsof –i >> ${DEBUGLOG}	

/bin/echo "5.4 - Arquivos de sistema alterados"
/bin/echo "5.4 - Arquivos de sistema alterados" >> ${DEBUGLOG}
/bin/rpm –Va >> ${DEBUGLOG}

/bin/echo "5.5 - Processos em execucao"
/bin/echo "5.5 - Processos em execucao" >> ${DEBUGLOG}
/bin/ps –ef >> ${DEBUGLOG}

/bin/echo "5.6 - Regras de firewall"
/bin/echo "5.6 - Regras de firewall" >> ${DEBUGLOG}
/sbin/iptables -nxvL >> ${DEBUGLOG}

/bin/echo "5.7 - Arquivo hosts"
/bin/echo "5.7 - Arquivo hosts" >> ${DEBUGLOG}
/bin/cat /etc/hosts >> ${DEBUGLOG}

/bin/echo "5.8 - Tarefas agendadas"
/bin/echo "5.8 - Tarefas agendadas" >> ${DEBUGLOG}
/bin/echo "Arquivos do /var/spool/cron/*" >> ${DEBUGLOG}
/bin/cat /var/spool/cron/* >> ${DEBUGLOG} 2>>/dev/null

/bin/echo "Conteudo do /etc/crontab" >> ${DEBUGLOG}
/bin/cat /etc/crontab >> ${DEBUGLOG}

/bin/echo "5.9 - Consultando falhas de login (Maximo 10 ocorrencias)"
/bin/echo "5.9 - Consultando falhas de login (Maximo 10 ocorrencias)" >> ${DEBUGLOG}
/bin/grep "Too many connections" /var/log/messages
/var/log/secure | head >> ${DEBUGLOG}

/bin/echo "5.9.1 - Verificando se existe processo de syslog ativo"
/bin/echo "5.9.1 - Verificando se existe processo de syslog ativo" >> ${DEBUGLOG}
/bin/ps –ef | grep log >> ${DEBUGLOG}

/bin/echo "5.10 - Procurando por arquivos com permissao de leitura, execucao e escrita para todos os usuarios. (0777)"
/bin/echo "5.10 - Procurando por arquivos com permissao de leitura, execucao e escrita para todos os usuarios. (0777)" >> ${DEBUGLOG}
/bin/find / -perm 0777 >> ${DEBUGLOG} 2>>/dev/null

/bin/echo "5.10.1 - Procurando por arquivos com permissao de Suid para Grupo (2000)"
/bin/echo "5.10.1 - Procurando por arquivos com permissao de Suid para Grupo (2000)" >> ${DEBUGLOG}
/bin/find / -perm 2000 >> ${DEBUGLOG} 2>>/dev/null

/bin/echo "5.10.2 - Procurando por Suid para o usuario(4000)"
/bin/echo "5.10 .2- Procurando por Suid para o usuario(4000)" >> ${DEBUGLOG}
/bin/find / -perm 4000 >> ${DEBUGLOG} 2>>/dev/null

/bin/echo "5.10.3 - Procurando por arquivos ocultos"
/bin/echo "5.10.3 - Procurando por arquivos ocultos" >> ${DEBUGLOG}
/bin/find / -type f -name ".*" >> ${DEBUGLOG} 2>>/dev/null

/bin/echo "5.10.4 - Procurando por diretorios ocultos"
/bin/echo "5.10.4 - Procurando por diretorios ocultos" >> ${DEBUGLOG}
/bin/find / -type d -name ".*" > ${DEBUGLOG} 2>>/dev/null

/bin/echo "5.10.5 - Procurando por chaves para sessao SSH"
/bin/echo "5.10.5 - Procurando por chaves para sessao SSH" >> ${DEBUGLOG}
/bin/find /home/ -name authorized_keys >> ${DEBUGLOG} 2>>/dev/null

/bin/echo "Fim da coleta de informacoes" >> ${DEBUGLOG}
/bin/echo ""
/bin/echo "O seguinte arquivo foi gerado e deve ser transferido para um host remoto para analise:"
/bin/echo "${DEBUGLOG}"
/bin/echo ""
exit 0;