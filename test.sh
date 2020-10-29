rm -Rf out/

function template() {
  dir=$1
  helm template release --set serviceAccount.name="my-service-account" ./$1 | awk -vout=out -F": " '$0~/^# Source: /{file=out"/"$2; print "Creating "file; system ("mkdir -p $(dirname "file"); echo -n "" > "file)} $0!~/^#/ && $0!="---"{print $0 >> file}'
}

template clean
template dirty


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
