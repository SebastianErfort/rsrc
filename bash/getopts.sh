VERBOSE=false
DRY=false
while getopts n:v: option; do
  case "$option" in
    n)
      DRY=true;;
    v)
      VERBOSE=true;;
    *)
      echo "Unknown option $option."
  esac
done

$DRY && echo "Simulating.." || echo "Executing.."
$VERBOSE && { echo "Verbose output:"; env; }
