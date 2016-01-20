# Script to collect evidences from compromised system (Windows)
#Script para coleta de evidencias de sistema comprometido - Windows
#Autor: Alan Santos - alanwds@gmail.com
#Data: 12/09/2012
#Revisão: Fábio Aoki - faoki
#Para que o script colete todas as evidencias é necessário que a máquina possua os seguintes aplicativos:
#Depends
#Sysinternals - http://technet.microsoft.com/en-us/sysinternals/bb842062.aspx
#Fport - http://www.mcafee.com/br/downloads/free-tools/fport.aspx

set mydate=%date:~6,4%%date:~3,2%%date:~0,2%
set filename=%systemroot%\Logs\secure_%mydate%.log

##Iniciando script
echo "Iniciando coleta de dados - %date% %time%" >> %filename%

echo "Coletando conexoes de rede e portas abertas..." >> %filename%
netstat /a /n >> %filename%

echo "Coletando binarios que estejam em modo listen" >> %filename%
%systemdrive%\Fport>fport >> %filename%

echo "Coletando tabela de roteamento" >> %filename%
netstat /r /n >> %filename%

echo "Coletando tabelas em cache - NETBIOS" >> %filename%
Nbtstat /c >> %filename%

echo "Coletando usuarios logados" >> %filename%
%systemdrive%\Sysinternals\PsloggedOn >> %filename%

echo "Coletando processos ativos" >> %filename%
%systemdrive%\Sysinternals\PsList >> %filename%

echo "Coletando servicos ativos" >> %filename%
%systemdrive%\Sysinternals\psservice >> %filename%

echo "Coletando tarefas agendadas" >> %filename%
at >> %filename%

echo "Coletando arquivos abertos" >> %filename%
%systemdrive%\Sysinternals\PsFile >> %filename%

echo "FIM DA COLETA DE DADOS" >> %filename%

forfiles /P %systemroot%\Logs /M secure*.log /D -30 /C "cmd.exe /c del @file"