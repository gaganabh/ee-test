FROM centos
RUN yum update -y
RUN yum install java-1.8.0-openjdk git maven -y
RUN mkdir -p /mnt/artefact
WORKDIR /mnt/artefact
RUN git clone https://github.com/spring-projects/spring-petclinic.git
RUN cd spring-petclinic && mvn -f pom.xml package
WORKDIR /mnt/artefact/spring-petclinic/target
ENTRYPOINT ["java", "-jar", "spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar"]
