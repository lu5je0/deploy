rm commandserver-*.jar
cd commandserver/
git pull origin master
mvn package
mv target/commandserver-*.jar ../
cd ..
./stop-command-server.sh
JAR=`ls *.jar`
nohup java -jar $JAR --spring.config.location=application.yml &
