rm -Rf out/

helm template release --set serviceAccount.name="my-service-account" ./clean | awk -vout=out -F": " '$0~/^# Source: /{file=out"/"$2; print "Creating "file; system ("mkdir -p $(dirname "file"); echo -n "" > "file)} $0!~/^#/ && $0!="---"{print $0 >> file}'
helm template release --set serviceAccount.name="my-service-account" ./dirty | awk -vout=out -F": " '$0~/^# Source: /{file=out"/"$2; print "Creating "file; system ("mkdir -p $(dirname "file"); echo -n "" > "file)} $0!~/^#/ && $0!="---"{print $0 >> file}'

has_failures=0

for f in out/clean/templates/*.yaml
do
  echo "Executing conftest against $f"
  conftest test $f
  if [ $? != 0 ]; then
    has_failures=1
  fi
done

if [ has_failures != 0 ]; then
  echo "Had failures on a clean image!"
fi

for f in out/dirty/templates/*.yaml
do
  echo "Executing conftest against $f"
  conftest test $f
done

echo "Did we get all the failures?"
