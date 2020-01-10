JAR='commandserver-*.jar'
DIR='commandserver'

rm -f $JAR
cd $DIR/
if [[ $1 == "-f" || `git pull origin master` != "Already up-to-date." ]]
then
  ps -ef | grep $JAR | grep -v grep | awk '{print $2}' | xargs kill
  mvn package
  mv target/$JAR ../
  cd ..
  JAR=`ls *.jar`
  nohup java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8181 -Xmx600M -jar $JAR --spring.config.location=application.yml &
  echo `date` `ls *.jar` >> deploy.log
else
  echo "Already up-to-date."
fi
