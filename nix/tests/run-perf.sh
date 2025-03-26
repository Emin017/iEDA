set -e

export WORKSPACE=$(cd "$(dirname "$0")";pwd)

# (fixed) iEDA setting
export CONFIG_DIR=$WORKSPACE/iEDA_config
export FOUNDRY_DIR=$WORKSPACE/../../foundry/sky130
export RESULT_DIR=$WORKSPACE/result
export TCL_SCRIPT_DIR=$WORKSPACE/script

# design files
export DESIGN_TOP=gcd
export NETLIST_FILE=$WORKSPACE/result/verilog/gcd.v
export SDC_FILE=$FOUNDRY_DIR/sdc/gcd.sdc
export SPEF_FILE=$FOUNDRY_DIR/spef/gcd.spef

# floorplan setting
## gcd
export DIE_AREA="0.0    0.0   149.96   150.128"
export CORE_AREA="9.996 10.08 139.964  140.048"

# system variables
PATH=$WORKSPACE/../../../bin:$PATH
IEDA=../../../result/bin/iEDA

${IEDA} -script "${TCL_SCRIPT_DIR}/iFP_script/run_iFP.tcl"
sed -i 's/\( [^+ ]*\) + NET  +/\1 + NET\1 +/' ${RESULT_DIR}/iFP_result.def

TCL_SCRIPTS="
iTO_script/run_iTO_drv.tcl
"

for SCRIPT in $TCL_SCRIPTS; do
    echo ">>> $ iEDA -script ${TCL_SCRIPT_DIR}/${SCRIPT}"
    CPUPROFILE=main.prof CPUPROFILE_FREQUENCY=100000 ${IEDA} -script "${TCL_SCRIPT_DIR}/${SCRIPT}"
done