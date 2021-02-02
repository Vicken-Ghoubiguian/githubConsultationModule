#Put the PowerShell image as image's base
FROM mcr.microsoft.com/powershell

#
LABEL maintainer="ericghoubiguian@live.fr"

#Copy all the files and directories in the newly created directory githubConsultationModule
COPY . /githubConsultationModule

#Change work directory for the githubConsultationModule one
WORKDIR /githubConsultationModule

#Define the Dockerfile argument 'fromExecMode' to specify if the githubConsultationModule will be installed in OS or not 
ARG fromExecMode

#Define the environment variable 'execMode' to take the 'fromExecMode' argument value and put it to run the app
ENV execMode=$fromExecMode



CMD [ "ls" ]