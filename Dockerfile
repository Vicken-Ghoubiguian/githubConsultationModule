#Put the PowerShell image as image's base
FROM mcr.microsoft.com/powershell

#
LABEL maintainer="ericghoubiguian@live.fr"

#Copy all the files and directories in the newly created directory githubConsultationModule
COPY . /githubConsultationModule

#Define the Dockerfile argument 'wishedSample' to specify the wished sample
ARG wishedSample

#Define the environment variable 'envWishedSample' to take the 'wishedSample' argument value and put it to run all
ENV envWishedSample=$wishedSample

#Define the Dockerfile argument 'wishedFolder' to specify the wished folder ('integratedSamples' or 'simpleSamples')
ARG wishedFolder

#Define the environment variable 'envWishedFolder' to take the 'wishedFolder' argument value and put it to run all
ENV envWishedFolder=$wishedFolder

#Change work directory for the samples one the githubConsultationModule project
WORKDIR /githubConsultationModule/samples

#




CMD ls "${envWishedFolder}"