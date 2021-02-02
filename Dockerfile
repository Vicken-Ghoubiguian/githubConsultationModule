#Put the PowerShell image as image's base
FROM mcr.microsoft.com/powershell

#
LABEL maintainer="ericghoubiguian@live.fr"

#Copy all the files and directories in the newly created directory githubConsultationModule
COPY . /githubConsultationModule

#Change work directory for the githubConsultationModule one
WORKDIR /githubConsultationModule

CMD [ "ping", "localhost", "-t" ]