str="./grpc"

for var in $@
do
  str="${str} ${var}" 
done

echo $str
eval $str
