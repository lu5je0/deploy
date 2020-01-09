JAR='syncbs-*.jar'
DIR='SynCBS'

rm -f $JAR
cd $DIR/
if [[ $1 == "-f" || `git pull origin master` != "Already up-to-date." ]]
then
  mvn package
  mv target/$JAR ../
  cd ..
  ps -ef | grep $JAR | grep -v grep | awk '{print $2}' | xargs kill
  JAR=`ls *.jar`
  nohup java -Xmx600M -jar $JAR --spring.config.location=application.yml &
else
  echo "Already up-to-date."
fi
