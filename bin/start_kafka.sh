set -e

show_help() {
  echo "Usage:";
  echo "  -h, --help: display this message";
  echo "  -d, --kafka_path: The path to the kafka installation (required)";
  echo "  -z, --zookeeper_config: the path of the configuration file";
  echo "  -k, --kafka_config: the path of the configuration file";
  exit 1;
}

# default values
z="zookeeper.properties"
k="server.properties"

while true ; do
  case "$1" in
    -h|--help)
      show_help ;;
    -d|--kafka-path)
      d=${2} ;
      shift 2 ;;
    -z|--zookeeper-config)
      z=${2} ;
      shift 2 ;;
    -k|--kafka_config)
      k=${2} ;
      shift 2 ;;
    *)
      break ;
      shift 2 ;;
  esac
done

# make sure the path is defined
if [ ! -d "${d}" ]; then echo "invalid kafka path ${d}" ; exit 1 ; fi
if [ ! -f "${z}" ]; then echo "invalid zookeeper path \"${z}\"" ; exit 1 ; fi
if [ ! -f "${k}" ]; then echo "invalid kafka config path \"${k}\"" ; exit 1 ; fi

"${d}/bin/zookeeper-server-start.sh" ${z} &
"${d}/bin/kafka-server-start.sh" ${k} &

exit 1