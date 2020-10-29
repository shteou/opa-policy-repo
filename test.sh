rm -Rf out/

function template() {
  dir=$1
  printf "Templating $1\n"
  helm template release --set serviceAccount.name="my-service-account" ./$1 | awk -vout=out -F": " '$0~/^# Source: /{file=out"/"$2; print "Creating "file; system ("mkdir -p $(dirname "file"); printf -n "" > "file)} $0!~/^#/ && $0!="---"{print $0 >> file}'
  printf "\n"
}

template clean
template dirty


has_failures=0

printf "Executing conftest against clean yaml files\n"

for f in out/clean/templates/*.yaml
do
  printf "Executing conftest against $f\n"
  conftest test $f
  if [ $? != 0 ]; then
    has_failures=1
  fi
done

if [ $has_failures != 0 ]; then
  printf "Had failures on a clean image!\n"
fi

printf "\nExecuting conftest against dirty yaml files\n"

for f in out/dirty/templates/*.yaml
do
  printf "Executing conftest against $f\n"
  conftest test $f
done

printf "Did we get all the failures?\n"
