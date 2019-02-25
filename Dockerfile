FROM benisson/wildfly-tuhe:latest

COPY deployments $JBOSS_HOME/standalone/deployments

# Temporario: o lookup está sendo feito para o jndi 'ear-0.0.1-SNAPSHOT'
#RUN mv $JBOSS_HOME/standalone/deployments/*ear $JBOSS_HOME/standalone/deployments/octopus.ear
#RUN mv $JBOSS_HOME/standalone/deployments/*ear $JBOSS_HOME/standalone/deployments/

RUN echo tuhe=f77567308bc51ca75b14e63015c568d7 > $JBOSS_HOME/standalone/configuration/mgmt-users.properties
RUN echo tuhe=f77567308bc51ca75b14e63015c568d7 > $JBOSS_HOME/domain/configuration/mgmt-users.properties
RUN echo tuhe= > $JBOSS_HOME/standalone/configuration/mgmt-groups.properties
RUN echo tuhe= > $JBOSS_HOME/domain/configuration/mgmt-groups.properties
#RUN rm -f $JBOSS_HOME/standalone/configuration/*.xml
#COPY standalone.conf $JBOSS_HOME/bin
#COPY standalone.xml $JBOSS_HOME/standalone/configuration
#COPY graylog2.tar.gz $JBOSS_HOME/modules/system/layers/base/org/
#RUN tar -zvxf $JBOSS_HOME/modules/system/layers/base/org/graylog2.tar.gz -C $JBOSS_HOME/modules/system/layers/base/org/; rm -vf $JBOSS_HOME/modules/system/layers/base/org/graylog2.tar.gz

## Set Timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#ADD  ./ear-1.0.1.ear  $JBOSS_HOME/standalone/deployments/