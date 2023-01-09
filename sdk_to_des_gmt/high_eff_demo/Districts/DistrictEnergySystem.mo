within high_eff_demo.Districts;
model DistrictEnergySystem
  extends Modelica.Icons.Example;
  // District Parameters
  package MediumW=Buildings.Media.Water
    "Source side medium";
  package MediumA=Buildings.Media.Air
    "Load side medium";

  // TODO: dehardcode these
  parameter Modelica.Units.SI.TemperatureDifference delChiWatTemDis(displayUnit="degC")=7;
  parameter Modelica.Units.SI.TemperatureDifference delChiWatTemBui(displayUnit="degC")=5;
  parameter Modelica.Units.SI.TemperatureDifference delHeaWatTemDis(displayUnit="degC")=12;
  parameter Modelica.Units.SI.TemperatureDifference delHeaWatTemBui(displayUnit="degC")=5;

  // Models

  //
  // Begin Model Instance for disNet_a752939f
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_a752939f=13;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_a752939f=sum({
    cooInd_3c4c4b87.mDis_flow_nominal,
  cooInd_b5a76684.mDis_flow_nominal,
  cooInd_f20214bc.mDis_flow_nominal,
  cooInd_457ffb93.mDis_flow_nominal,
  cooInd_5627dad0.mDis_flow_nominal,
  cooInd_fd7873c6.mDis_flow_nominal,
  cooInd_63ede8a9.mDis_flow_nominal,
  cooInd_23a4061b.mDis_flow_nominal,
  cooInd_c4dbbad6.mDis_flow_nominal,
  cooInd_a4d657a9.mDis_flow_nominal,
  cooInd_7f77fff9.mDis_flow_nominal,
  cooInd_2fa0b7df.mDis_flow_nominal,
  cooInd_b32df680.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_a752939f[nBui_disNet_a752939f]={
    cooInd_3c4c4b87.mDis_flow_nominal,
  cooInd_b5a76684.mDis_flow_nominal,
  cooInd_f20214bc.mDis_flow_nominal,
  cooInd_457ffb93.mDis_flow_nominal,
  cooInd_5627dad0.mDis_flow_nominal,
  cooInd_fd7873c6.mDis_flow_nominal,
  cooInd_63ede8a9.mDis_flow_nominal,
  cooInd_23a4061b.mDis_flow_nominal,
  cooInd_c4dbbad6.mDis_flow_nominal,
  cooInd_a4d657a9.mDis_flow_nominal,
  cooInd_7f77fff9.mDis_flow_nominal,
  cooInd_2fa0b7df.mDis_flow_nominal,
  cooInd_b32df680.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_a752939f[nBui_disNet_a752939f](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_a752939f*0.1},
    fill(
      dp_nominal_disNet_a752939f*0.9/(nBui_disNet_a752939f-1),
      nBui_disNet_a752939f-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_a752939f=dpSetPoi_disNet_a752939f+nBui_disNet_a752939f*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_a752939f=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_a752939f(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_a752939f,
    iConDpSen=nBui_disNet_a752939f,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_a752939f,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_a752939f,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_a752939f)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,780.0},{-10.0,790.0}})));
  //
  // End Model Instance for disNet_a752939f
  //


  
  //
  // Begin Model Instance for cooPla_9423f0cc
  // Source template: /model_connectors/plants/templates/CoolingPlant_Instance.mopt
  //
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal_cooPla_9423f0cc=cooPla_9423f0cc.numChi*(cooPla_9423f0cc.perChi.mEva_flow_nominal)
    "Nominal chilled water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal_cooPla_9423f0cc=cooPla_9423f0cc.perChi.mCon_flow_nominal
    "Nominal condenser water mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dpCHW_nominal_cooPla_9423f0cc=44.8*1000
    "Nominal chilled water side pressure";
  parameter Modelica.Units.SI.PressureDifference dpCW_nominal_cooPla_9423f0cc=46.2*1000
    "Nominal condenser water side pressure";
  parameter Modelica.Units.SI.Power QEva_nominal_cooPla_9423f0cc=mCHW_flow_nominal_cooPla_9423f0cc*4200*(5-14)
    "Nominal cooling capaciaty (Negative means cooling)";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_cooPla_9423f0cc=0.2*mCHW_flow_nominal_cooPla_9423f0cc/cooPla_9423f0cc.numChi
    "Minimum mass flow rate of single chiller";
  // control settings
  parameter Modelica.Units.SI.Pressure dpSetPoi_cooPla_9423f0cc=70000
    "Differential pressure setpoint";
  parameter Modelica.Units.SI.Pressure pumDP_cooPla_9423f0cc=dpCHW_nominal_cooPla_9423f0cc+dpSetPoi_cooPla_9423f0cc+200000;
  parameter Modelica.Units.SI.Time tWai_cooPla_9423f0cc=30
    "Waiting time";
  // pumps
  parameter Buildings.Fluid.Movers.Data.Generic perCHWPum_cooPla_9423f0cc(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=((mCHW_flow_nominal_cooPla_9423f0cc/cooPla_9423f0cc.numChi)/1000)*{0.1,1,1.2},
      dp=pumDP_cooPla_9423f0cc*{1.2,1,0.1}))
    "Performance data for chilled water pumps";
  parameter Buildings.Fluid.Movers.Data.Generic perCWPum_cooPla_9423f0cc(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mCW_flow_nominal_cooPla_9423f0cc/1000*{0.2,0.6,1.0,1.2},
      dp=(dpCW_nominal_cooPla_9423f0cc+60000+6000)*{1.2,1.1,1.0,0.6}))
    "Performance data for condenser water pumps";


  Modelica.Blocks.Sources.RealExpression TSetChiWatDis_cooPla_9423f0cc(
    y=5+273.15)
    "Chilled water supply temperature set point on district level."
    annotation (Placement(transformation(extent={{10.0,-790.0},{30.0,-770.0}})));
  Modelica.Blocks.Sources.BooleanConstant on_cooPla_9423f0cc
    "On signal of the plant"
    annotation (Placement(transformation(extent={{50.0,-790.0},{70.0,-770.0}})));

  high_eff_demo.Plants.CentralCoolingPlant cooPla_9423f0cc(
    redeclare Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19EX_5208kW_6_88COP_Vanes perChi,
    perCHWPum=perCHWPum_cooPla_9423f0cc,
    perCWPum=perCWPum_cooPla_9423f0cc,
    mCHW_flow_nominal=mCHW_flow_nominal_cooPla_9423f0cc,
    dpCHW_nominal=dpCHW_nominal_cooPla_9423f0cc,
    QEva_nominal=QEva_nominal_cooPla_9423f0cc,
    mMin_flow=mMin_flow_cooPla_9423f0cc,
    mCW_flow_nominal=mCW_flow_nominal_cooPla_9423f0cc,
    dpCW_nominal=dpCW_nominal_cooPla_9423f0cc,
    TAirInWB_nominal=298.7,
    TCW_nominal=308.15,
    TMin=288.15,
    tWai=tWai_cooPla_9423f0cc,
    dpSetPoi=dpSetPoi_cooPla_9423f0cc
    )
    "District cooling plant."
    annotation (Placement(transformation(extent={{-70.0,770.0},{-50.0,790.0}})));
  //
  // End Model Instance for cooPla_9423f0cc
  //


  
  //
  // Begin Model Instance for disNet_2feea5e7
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_2feea5e7=13;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_2feea5e7=sum({
    heaInd_0524babc.mDis_flow_nominal,
  heaInd_34e2d2aa.mDis_flow_nominal,
  heaInd_d03a546f.mDis_flow_nominal,
  heaInd_519466b8.mDis_flow_nominal,
  heaInd_8414d585.mDis_flow_nominal,
  heaInd_4dc395d3.mDis_flow_nominal,
  heaInd_e5bf5b65.mDis_flow_nominal,
  heaInd_c3a33ae9.mDis_flow_nominal,
  heaInd_84951389.mDis_flow_nominal,
  heaInd_2820df07.mDis_flow_nominal,
  heaInd_b5e8a543.mDis_flow_nominal,
  heaInd_c1bff424.mDis_flow_nominal,
  heaInd_649c2ac7.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_2feea5e7[nBui_disNet_2feea5e7]={
    heaInd_0524babc.mDis_flow_nominal,
  heaInd_34e2d2aa.mDis_flow_nominal,
  heaInd_d03a546f.mDis_flow_nominal,
  heaInd_519466b8.mDis_flow_nominal,
  heaInd_8414d585.mDis_flow_nominal,
  heaInd_4dc395d3.mDis_flow_nominal,
  heaInd_e5bf5b65.mDis_flow_nominal,
  heaInd_c3a33ae9.mDis_flow_nominal,
  heaInd_84951389.mDis_flow_nominal,
  heaInd_2820df07.mDis_flow_nominal,
  heaInd_b5e8a543.mDis_flow_nominal,
  heaInd_c1bff424.mDis_flow_nominal,
  heaInd_649c2ac7.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_2feea5e7[nBui_disNet_2feea5e7](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_2feea5e7*0.1},
    fill(
      dp_nominal_disNet_2feea5e7*0.9/(nBui_disNet_2feea5e7-1),
      nBui_disNet_2feea5e7-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_2feea5e7=dpSetPoi_disNet_2feea5e7+nBui_disNet_2feea5e7*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_2feea5e7=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_2feea5e7(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_2feea5e7,
    iConDpSen=nBui_disNet_2feea5e7,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_2feea5e7,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_2feea5e7,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_2feea5e7)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,740.0},{-10.0,750.0}})));
  //
  // End Model Instance for disNet_2feea5e7
  //


  
  //
  // Begin Model Instance for heaPlafa600d24
  // Source template: /model_connectors/plants/templates/HeatingPlant_Instance.mopt
  //
  // heating plant instance
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal_heaPlafa600d24=mBoi_flow_nominal_heaPlafa600d24*heaPlafa600d24.numBoi
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal_heaPlafa600d24=QBoi_nominal_heaPlafa600d24/(4200*heaPlafa600d24.delT_nominal)
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.Power QBoi_nominal_heaPlafa600d24=Q_flow_nominal_heaPlafa600d24/heaPlafa600d24.numBoi
    "Nominal heating capaciaty";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_heaPlafa600d24=1000000*2
    "Heating load";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_heaPlafa600d24=0.2*mBoi_flow_nominal_heaPlafa600d24
    "Minimum mass flow rate of single boiler";
  // controls
  parameter Modelica.Units.SI.Pressure pumDP=(heaPlafa600d24.dpBoi_nominal+dpSetPoi_disNet_2feea5e7+50000)
    "Heating water pump pressure drop";
  parameter Modelica.Units.SI.Time tWai_heaPlafa600d24=30
    "Waiting time";
  parameter Buildings.Fluid.Movers.Data.Generic perHWPum_heaPlafa600d24(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mBoi_flow_nominal_heaPlafa600d24/1000*{0.1,1.1},
      dp=pumDP*{1.1,0.1}))
    "Performance data for heating water pumps";

  high_eff_demo.Plants.CentralHeatingPlant heaPlafa600d24(
    perHWPum=perHWPum_heaPlafa600d24,
    mHW_flow_nominal=mHW_flow_nominal_heaPlafa600d24,
    QBoi_flow_nominal=QBoi_nominal_heaPlafa600d24,
    mMin_flow=mMin_flow_heaPlafa600d24,
    mBoi_flow_nominal=mBoi_flow_nominal_heaPlafa600d24,
    dpBoi_nominal=10000,
    delT_nominal(
      displayUnit="degC")=15,
    tWai=tWai_heaPlafa600d24,
    // TODO: we're currently grabbing dpSetPoi from the Network instance -- need feedback to determine if that's the proper "home" for it
    dpSetPoi=dpSetPoi_disNet_2feea5e7
    )
    "District heating plant."
    annotation (Placement(transformation(extent={{-70.0,730.0},{-50.0,750.0}})));
  //
  // End Model Instance for heaPlafa600d24
  //


  
  //
  // Begin Model Instance for TimeSerLoa_377d8bff
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B1.TimeSeriesBuilding TimeSerLoa_377d8bff(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,770.0},{70.0,790.0}})));
  //
  // End Model Instance for TimeSerLoa_377d8bff
  //


  
  //
  // Begin Model Instance for cooInd_3c4c4b87
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_1 cooInd_3c4c4b87(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_368e0093,
    mBui_flow_nominal=mBui_flow_nominal_368e0093,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_368e0093,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,730.0},{30.0,750.0}})));
  //
  // End Model Instance for cooInd_3c4c4b87
  //


  
  //
  // Begin Model Instance for heaInd_0524babc
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_1 heaInd_0524babc(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_f0c49fa9,
    mBui_flow_nominal=mBui_flow_nominal_f0c49fa9,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_f0c49fa9,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,770.0},{30.0,790.0}})));
  //
  // End Model Instance for heaInd_0524babc
  //


  
  //
  // Begin Model Instance for TimeSerLoa_0f322c95
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B2.TimeSeriesBuilding TimeSerLoa_0f322c95(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,690.0},{70.0,710.0}})));
  //
  // End Model Instance for TimeSerLoa_0f322c95
  //


  
  //
  // Begin Model Instance for cooInd_b5a76684
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_2 cooInd_b5a76684(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_90a17de7,
    mBui_flow_nominal=mBui_flow_nominal_90a17de7,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_90a17de7,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,690.0},{30.0,710.0}})));
  //
  // End Model Instance for cooInd_b5a76684
  //


  
  //
  // Begin Model Instance for heaInd_34e2d2aa
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_2 heaInd_34e2d2aa(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_27e45984,
    mBui_flow_nominal=mBui_flow_nominal_27e45984,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_27e45984,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,650.0},{30.0,670.0}})));
  //
  // End Model Instance for heaInd_34e2d2aa
  //


  
  //
  // Begin Model Instance for TimeSerLoa_70d22094
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B3.TimeSeriesBuilding TimeSerLoa_70d22094(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,610.0},{70.0,630.0}})));
  //
  // End Model Instance for TimeSerLoa_70d22094
  //


  
  //
  // Begin Model Instance for cooInd_f20214bc
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_3 cooInd_f20214bc(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_e2766992,
    mBui_flow_nominal=mBui_flow_nominal_e2766992,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_e2766992,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,570.0},{30.0,590.0}})));
  //
  // End Model Instance for cooInd_f20214bc
  //


  
  //
  // Begin Model Instance for heaInd_d03a546f
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_3 heaInd_d03a546f(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_0969bc2c,
    mBui_flow_nominal=mBui_flow_nominal_0969bc2c,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_0969bc2c,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,610.0},{30.0,630.0}})));
  //
  // End Model Instance for heaInd_d03a546f
  //


  
  //
  // Begin Model Instance for TimeSerLoa_faccf18c
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B4.TimeSeriesBuilding TimeSerLoa_faccf18c(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,530.0},{70.0,550.0}})));
  //
  // End Model Instance for TimeSerLoa_faccf18c
  //


  
  //
  // Begin Model Instance for cooInd_457ffb93
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_4 cooInd_457ffb93(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_0a065413,
    mBui_flow_nominal=mBui_flow_nominal_0a065413,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_0a065413,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,490.0},{30.0,510.0}})));
  //
  // End Model Instance for cooInd_457ffb93
  //


  
  //
  // Begin Model Instance for heaInd_519466b8
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_4 heaInd_519466b8(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_c9454ec2,
    mBui_flow_nominal=mBui_flow_nominal_c9454ec2,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_c9454ec2,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,530.0},{30.0,550.0}})));
  //
  // End Model Instance for heaInd_519466b8
  //


  
  //
  // Begin Model Instance for TimeSerLoa_d1d54389
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B5.TimeSeriesBuilding TimeSerLoa_d1d54389(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,450.0},{70.0,470.0}})));
  //
  // End Model Instance for TimeSerLoa_d1d54389
  //


  
  //
  // Begin Model Instance for cooInd_5627dad0
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_5 cooInd_5627dad0(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_bb2c650d,
    mBui_flow_nominal=mBui_flow_nominal_bb2c650d,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_bb2c650d,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,450.0},{30.0,470.0}})));
  //
  // End Model Instance for cooInd_5627dad0
  //


  
  //
  // Begin Model Instance for heaInd_8414d585
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_5 heaInd_8414d585(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_e2d5599d,
    mBui_flow_nominal=mBui_flow_nominal_e2d5599d,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_e2d5599d,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,410.0},{30.0,430.0}})));
  //
  // End Model Instance for heaInd_8414d585
  //


  
  //
  // Begin Model Instance for TimeSerLoa_421efb76
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B6.TimeSeriesBuilding TimeSerLoa_421efb76(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,370.0},{70.0,390.0}})));
  //
  // End Model Instance for TimeSerLoa_421efb76
  //


  
  //
  // Begin Model Instance for cooInd_fd7873c6
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_6 cooInd_fd7873c6(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_26defd93,
    mBui_flow_nominal=mBui_flow_nominal_26defd93,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_26defd93,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,370.0},{30.0,390.0}})));
  //
  // End Model Instance for cooInd_fd7873c6
  //


  
  //
  // Begin Model Instance for heaInd_4dc395d3
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_6 heaInd_4dc395d3(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_a170f81a,
    mBui_flow_nominal=mBui_flow_nominal_a170f81a,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_a170f81a,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,330.0},{30.0,350.0}})));
  //
  // End Model Instance for heaInd_4dc395d3
  //


  
  //
  // Begin Model Instance for TimeSerLoa_9386ccaf
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B7.TimeSeriesBuilding TimeSerLoa_9386ccaf(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,290.0},{70.0,310.0}})));
  //
  // End Model Instance for TimeSerLoa_9386ccaf
  //


  
  //
  // Begin Model Instance for cooInd_63ede8a9
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_7 cooInd_63ede8a9(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_7036ff35,
    mBui_flow_nominal=mBui_flow_nominal_7036ff35,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_7036ff35,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,250.0},{30.0,270.0}})));
  //
  // End Model Instance for cooInd_63ede8a9
  //


  
  //
  // Begin Model Instance for heaInd_e5bf5b65
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_7 heaInd_e5bf5b65(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_d05d6fdc,
    mBui_flow_nominal=mBui_flow_nominal_d05d6fdc,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_d05d6fdc,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,290.0},{30.0,310.0}})));
  //
  // End Model Instance for heaInd_e5bf5b65
  //


  
  //
  // Begin Model Instance for TimeSerLoa_1bcd3162
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B8.TimeSeriesBuilding TimeSerLoa_1bcd3162(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,210.0},{70.0,230.0}})));
  //
  // End Model Instance for TimeSerLoa_1bcd3162
  //


  
  //
  // Begin Model Instance for cooInd_23a4061b
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_8 cooInd_23a4061b(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_5db929b9,
    mBui_flow_nominal=mBui_flow_nominal_5db929b9,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_5db929b9,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,170.0},{30.0,190.0}})));
  //
  // End Model Instance for cooInd_23a4061b
  //


  
  //
  // Begin Model Instance for heaInd_c3a33ae9
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_8 heaInd_c3a33ae9(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_fe21ec2e,
    mBui_flow_nominal=mBui_flow_nominal_fe21ec2e,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_fe21ec2e,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,210.0},{30.0,230.0}})));
  //
  // End Model Instance for heaInd_c3a33ae9
  //


  
  //
  // Begin Model Instance for TimeSerLoa_fec0cb2b
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B9.TimeSeriesBuilding TimeSerLoa_fec0cb2b(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,130.0},{70.0,150.0}})));
  //
  // End Model Instance for TimeSerLoa_fec0cb2b
  //


  
  //
  // Begin Model Instance for cooInd_c4dbbad6
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_9 cooInd_c4dbbad6(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_f45d602b,
    mBui_flow_nominal=mBui_flow_nominal_f45d602b,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_f45d602b,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,90.0},{30.0,110.0}})));
  //
  // End Model Instance for cooInd_c4dbbad6
  //


  
  //
  // Begin Model Instance for heaInd_84951389
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_9 heaInd_84951389(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_6e9a1cf3,
    mBui_flow_nominal=mBui_flow_nominal_6e9a1cf3,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_6e9a1cf3,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,130.0},{30.0,150.0}})));
  //
  // End Model Instance for heaInd_84951389
  //


  
  //
  // Begin Model Instance for TimeSerLoa_f0ceaaf3
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B10.TimeSeriesBuilding TimeSerLoa_f0ceaaf3(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,50.0},{70.0,70.0}})));
  //
  // End Model Instance for TimeSerLoa_f0ceaaf3
  //


  
  //
  // Begin Model Instance for cooInd_a4d657a9
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_10 cooInd_a4d657a9(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_a7cc180f,
    mBui_flow_nominal=mBui_flow_nominal_a7cc180f,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_a7cc180f,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,10.0},{30.0,30.0}})));
  //
  // End Model Instance for cooInd_a4d657a9
  //


  
  //
  // Begin Model Instance for heaInd_2820df07
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_10 heaInd_2820df07(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_6e8abfc2,
    mBui_flow_nominal=mBui_flow_nominal_6e8abfc2,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_6e8abfc2,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,50.0},{30.0,70.0}})));
  //
  // End Model Instance for heaInd_2820df07
  //


  
  //
  // Begin Model Instance for TimeSerLoa_4deaf2ef
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B11.TimeSeriesBuilding TimeSerLoa_4deaf2ef(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,-30.0},{70.0,-10.0}})));
  //
  // End Model Instance for TimeSerLoa_4deaf2ef
  //


  
  //
  // Begin Model Instance for cooInd_7f77fff9
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_11 cooInd_7f77fff9(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_87ad810f,
    mBui_flow_nominal=mBui_flow_nominal_87ad810f,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_87ad810f,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,-30.0},{30.0,-10.0}})));
  //
  // End Model Instance for cooInd_7f77fff9
  //


  
  //
  // Begin Model Instance for heaInd_b5e8a543
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_11 heaInd_b5e8a543(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_e77fbdf5,
    mBui_flow_nominal=mBui_flow_nominal_e77fbdf5,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_e77fbdf5,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,-70.0},{30.0,-50.0}})));
  //
  // End Model Instance for heaInd_b5e8a543
  //


  
  //
  // Begin Model Instance for TimeSerLoa_3acc8a8e
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B12.TimeSeriesBuilding TimeSerLoa_3acc8a8e(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,-110.0},{70.0,-90.0}})));
  //
  // End Model Instance for TimeSerLoa_3acc8a8e
  //


  
  //
  // Begin Model Instance for cooInd_2fa0b7df
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_12 cooInd_2fa0b7df(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_3a58dac6,
    mBui_flow_nominal=mBui_flow_nominal_3a58dac6,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_3a58dac6,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,-110.0},{30.0,-90.0}})));
  //
  // End Model Instance for cooInd_2fa0b7df
  //


  
  //
  // Begin Model Instance for heaInd_c1bff424
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_12 heaInd_c1bff424(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_ad9c3b92,
    mBui_flow_nominal=mBui_flow_nominal_ad9c3b92,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_ad9c3b92,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,-150.0},{30.0,-130.0}})));
  //
  // End Model Instance for heaInd_c1bff424
  //


  
  //
  // Begin Model Instance for TimeSerLoa_90fce148
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  high_eff_demo.Loads.B13.TimeSeriesBuilding TimeSerLoa_90fce148(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,-190.0},{70.0,-170.0}})));
  //
  // End Model Instance for TimeSerLoa_90fce148
  //


  
  //
  // Begin Model Instance for cooInd_b32df680
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  high_eff_demo.Substations.CoolingIndirect_13 cooInd_b32df680(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_59ecdc88,
    mBui_flow_nominal=mBui_flow_nominal_59ecdc88,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_59ecdc88,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,-230.0},{30.0,-210.0}})));
  //
  // End Model Instance for cooInd_b32df680
  //


  
  //
  // Begin Model Instance for heaInd_649c2ac7
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  high_eff_demo.Substations.HeatingIndirect_13 heaInd_649c2ac7(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_b9bbe8b5,
    mBui_flow_nominal=mBui_flow_nominal_b9bbe8b5,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_b9bbe8b5,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,-190.0},{30.0,-170.0}})));
  //
  // End Model Instance for heaInd_649c2ac7
  //


  

  // Model dependencies

  //
  // Begin Component Definitions for 1848589c
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ComponentDefinitions.mopt
  //
  // No components for pipe and cooling plant

  //
  // End Component Definitions for 1848589c
  //



  //
  // Begin Component Definitions for 157e41f2
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ComponentDefinitions.mopt
  //
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.BooleanConstant mPum_flow_157e41f2(
    k=true)
    "Total heating water pump mass flow rate"
    annotation (Placement(transformation(extent={{-70.0,-270.0},{-50.0,-250.0}})));
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.RealExpression TDisSetHeaWat_157e41f2(
    each y=273.15+54)
    "District side heating water supply temperature set point."
    annotation (Placement(transformation(extent={{-30.0,-270.0},{-10.0,-250.0}})));

  //
  // End Component Definitions for 157e41f2
  //



  //
  // Begin Component Definitions for 368e0093
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_368e0093=TimeSerLoa_377d8bff.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_368e0093=TimeSerLoa_377d8bff.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_368e0093=-1*(TimeSerLoa_377d8bff.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_368e0093(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-270.0},{30.0,-250.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_368e0093(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-270.0},{70.0,-250.0}})));

  //
  // End Component Definitions for 368e0093
  //



  //
  // Begin Component Definitions for c90313cc
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for c90313cc
  //



  //
  // Begin Component Definitions for f0c49fa9
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_f0c49fa9=TimeSerLoa_377d8bff.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_f0c49fa9=TimeSerLoa_377d8bff.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_f0c49fa9=(TimeSerLoa_377d8bff.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_f0c49fa9(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-310.0},{-50.0,-290.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_f0c49fa9(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-310.0},{-10.0,-290.0}})));

  //
  // End Component Definitions for f0c49fa9
  //



  //
  // Begin Component Definitions for 4664b4f7
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 4664b4f7
  //



  //
  // Begin Component Definitions for 90a17de7
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_90a17de7=TimeSerLoa_0f322c95.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_90a17de7=TimeSerLoa_0f322c95.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_90a17de7=-1*(TimeSerLoa_0f322c95.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_90a17de7(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-310.0},{30.0,-290.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_90a17de7(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-310.0},{70.0,-290.0}})));

  //
  // End Component Definitions for 90a17de7
  //



  //
  // Begin Component Definitions for 34d9fa3f
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 34d9fa3f
  //



  //
  // Begin Component Definitions for 27e45984
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_27e45984=TimeSerLoa_0f322c95.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_27e45984=TimeSerLoa_0f322c95.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_27e45984=(TimeSerLoa_0f322c95.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_27e45984(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-350.0},{-50.0,-330.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_27e45984(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-350.0},{-10.0,-330.0}})));

  //
  // End Component Definitions for 27e45984
  //



  //
  // Begin Component Definitions for 184b10e5
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 184b10e5
  //



  //
  // Begin Component Definitions for e2766992
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_e2766992=TimeSerLoa_70d22094.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_e2766992=TimeSerLoa_70d22094.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_e2766992=-1*(TimeSerLoa_70d22094.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_e2766992(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-350.0},{30.0,-330.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_e2766992(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-350.0},{70.0,-330.0}})));

  //
  // End Component Definitions for e2766992
  //



  //
  // Begin Component Definitions for 92e8bd11
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 92e8bd11
  //



  //
  // Begin Component Definitions for 0969bc2c
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_0969bc2c=TimeSerLoa_70d22094.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_0969bc2c=TimeSerLoa_70d22094.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_0969bc2c=(TimeSerLoa_70d22094.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_0969bc2c(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-390.0},{-50.0,-370.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_0969bc2c(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-390.0},{-10.0,-370.0}})));

  //
  // End Component Definitions for 0969bc2c
  //



  //
  // Begin Component Definitions for ae41518a
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for ae41518a
  //



  //
  // Begin Component Definitions for 0a065413
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_0a065413=TimeSerLoa_faccf18c.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_0a065413=TimeSerLoa_faccf18c.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_0a065413=-1*(TimeSerLoa_faccf18c.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_0a065413(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-390.0},{30.0,-370.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_0a065413(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-390.0},{70.0,-370.0}})));

  //
  // End Component Definitions for 0a065413
  //



  //
  // Begin Component Definitions for 915208f2
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 915208f2
  //



  //
  // Begin Component Definitions for c9454ec2
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_c9454ec2=TimeSerLoa_faccf18c.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_c9454ec2=TimeSerLoa_faccf18c.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_c9454ec2=(TimeSerLoa_faccf18c.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_c9454ec2(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-430.0},{-50.0,-410.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_c9454ec2(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-430.0},{-10.0,-410.0}})));

  //
  // End Component Definitions for c9454ec2
  //



  //
  // Begin Component Definitions for a6268b54
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for a6268b54
  //



  //
  // Begin Component Definitions for bb2c650d
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_bb2c650d=TimeSerLoa_d1d54389.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_bb2c650d=TimeSerLoa_d1d54389.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_bb2c650d=-1*(TimeSerLoa_d1d54389.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_bb2c650d(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-430.0},{30.0,-410.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_bb2c650d(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-430.0},{70.0,-410.0}})));

  //
  // End Component Definitions for bb2c650d
  //



  //
  // Begin Component Definitions for a6b3c8ee
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for a6b3c8ee
  //



  //
  // Begin Component Definitions for e2d5599d
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_e2d5599d=TimeSerLoa_d1d54389.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_e2d5599d=TimeSerLoa_d1d54389.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_e2d5599d=(TimeSerLoa_d1d54389.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_e2d5599d(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-470.0},{-50.0,-450.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_e2d5599d(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-470.0},{-10.0,-450.0}})));

  //
  // End Component Definitions for e2d5599d
  //



  //
  // Begin Component Definitions for 9aca04d3
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 9aca04d3
  //



  //
  // Begin Component Definitions for 26defd93
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_26defd93=TimeSerLoa_421efb76.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_26defd93=TimeSerLoa_421efb76.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_26defd93=-1*(TimeSerLoa_421efb76.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_26defd93(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-470.0},{30.0,-450.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_26defd93(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-470.0},{70.0,-450.0}})));

  //
  // End Component Definitions for 26defd93
  //



  //
  // Begin Component Definitions for 62d24f38
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 62d24f38
  //



  //
  // Begin Component Definitions for a170f81a
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_a170f81a=TimeSerLoa_421efb76.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_a170f81a=TimeSerLoa_421efb76.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_a170f81a=(TimeSerLoa_421efb76.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_a170f81a(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-510.0},{-50.0,-490.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_a170f81a(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-510.0},{-10.0,-490.0}})));

  //
  // End Component Definitions for a170f81a
  //



  //
  // Begin Component Definitions for 843aa841
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 843aa841
  //



  //
  // Begin Component Definitions for 7036ff35
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_7036ff35=TimeSerLoa_9386ccaf.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_7036ff35=TimeSerLoa_9386ccaf.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_7036ff35=-1*(TimeSerLoa_9386ccaf.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_7036ff35(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-510.0},{30.0,-490.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_7036ff35(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-510.0},{70.0,-490.0}})));

  //
  // End Component Definitions for 7036ff35
  //



  //
  // Begin Component Definitions for fc49554a
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for fc49554a
  //



  //
  // Begin Component Definitions for d05d6fdc
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_d05d6fdc=TimeSerLoa_9386ccaf.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_d05d6fdc=TimeSerLoa_9386ccaf.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_d05d6fdc=(TimeSerLoa_9386ccaf.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_d05d6fdc(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-550.0},{-50.0,-530.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_d05d6fdc(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-550.0},{-10.0,-530.0}})));

  //
  // End Component Definitions for d05d6fdc
  //



  //
  // Begin Component Definitions for f41d9adc
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for f41d9adc
  //



  //
  // Begin Component Definitions for 5db929b9
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_5db929b9=TimeSerLoa_1bcd3162.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_5db929b9=TimeSerLoa_1bcd3162.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_5db929b9=-1*(TimeSerLoa_1bcd3162.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_5db929b9(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-550.0},{30.0,-530.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_5db929b9(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-550.0},{70.0,-530.0}})));

  //
  // End Component Definitions for 5db929b9
  //



  //
  // Begin Component Definitions for de537ca4
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for de537ca4
  //



  //
  // Begin Component Definitions for fe21ec2e
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_fe21ec2e=TimeSerLoa_1bcd3162.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_fe21ec2e=TimeSerLoa_1bcd3162.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_fe21ec2e=(TimeSerLoa_1bcd3162.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_fe21ec2e(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-590.0},{-50.0,-570.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_fe21ec2e(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-590.0},{-10.0,-570.0}})));

  //
  // End Component Definitions for fe21ec2e
  //



  //
  // Begin Component Definitions for 908ab319
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 908ab319
  //



  //
  // Begin Component Definitions for f45d602b
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_f45d602b=TimeSerLoa_fec0cb2b.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_f45d602b=TimeSerLoa_fec0cb2b.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_f45d602b=-1*(TimeSerLoa_fec0cb2b.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_f45d602b(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-590.0},{30.0,-570.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_f45d602b(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-590.0},{70.0,-570.0}})));

  //
  // End Component Definitions for f45d602b
  //



  //
  // Begin Component Definitions for de15f740
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for de15f740
  //



  //
  // Begin Component Definitions for 6e9a1cf3
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_6e9a1cf3=TimeSerLoa_fec0cb2b.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_6e9a1cf3=TimeSerLoa_fec0cb2b.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_6e9a1cf3=(TimeSerLoa_fec0cb2b.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_6e9a1cf3(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-630.0},{-50.0,-610.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_6e9a1cf3(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-630.0},{-10.0,-610.0}})));

  //
  // End Component Definitions for 6e9a1cf3
  //



  //
  // Begin Component Definitions for b969f858
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for b969f858
  //



  //
  // Begin Component Definitions for a7cc180f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_a7cc180f=TimeSerLoa_f0ceaaf3.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_a7cc180f=TimeSerLoa_f0ceaaf3.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_a7cc180f=-1*(TimeSerLoa_f0ceaaf3.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_a7cc180f(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-630.0},{30.0,-610.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_a7cc180f(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-630.0},{70.0,-610.0}})));

  //
  // End Component Definitions for a7cc180f
  //



  //
  // Begin Component Definitions for 208d7d08
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 208d7d08
  //



  //
  // Begin Component Definitions for 6e8abfc2
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_6e8abfc2=TimeSerLoa_f0ceaaf3.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_6e8abfc2=TimeSerLoa_f0ceaaf3.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_6e8abfc2=(TimeSerLoa_f0ceaaf3.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_6e8abfc2(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-670.0},{-50.0,-650.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_6e8abfc2(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-670.0},{-10.0,-650.0}})));

  //
  // End Component Definitions for 6e8abfc2
  //



  //
  // Begin Component Definitions for 21c80720
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 21c80720
  //



  //
  // Begin Component Definitions for 87ad810f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_87ad810f=TimeSerLoa_4deaf2ef.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_87ad810f=TimeSerLoa_4deaf2ef.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_87ad810f=-1*(TimeSerLoa_4deaf2ef.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_87ad810f(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-670.0},{30.0,-650.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_87ad810f(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-670.0},{70.0,-650.0}})));

  //
  // End Component Definitions for 87ad810f
  //



  //
  // Begin Component Definitions for 67daf811
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 67daf811
  //



  //
  // Begin Component Definitions for e77fbdf5
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_e77fbdf5=TimeSerLoa_4deaf2ef.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_e77fbdf5=TimeSerLoa_4deaf2ef.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_e77fbdf5=(TimeSerLoa_4deaf2ef.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_e77fbdf5(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-710.0},{-50.0,-690.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_e77fbdf5(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-710.0},{-10.0,-690.0}})));

  //
  // End Component Definitions for e77fbdf5
  //



  //
  // Begin Component Definitions for 9961c4c8
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 9961c4c8
  //



  //
  // Begin Component Definitions for 3a58dac6
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_3a58dac6=TimeSerLoa_3acc8a8e.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_3a58dac6=TimeSerLoa_3acc8a8e.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_3a58dac6=-1*(TimeSerLoa_3acc8a8e.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_3a58dac6(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-710.0},{30.0,-690.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_3a58dac6(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-710.0},{70.0,-690.0}})));

  //
  // End Component Definitions for 3a58dac6
  //



  //
  // Begin Component Definitions for af11d010
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for af11d010
  //



  //
  // Begin Component Definitions for ad9c3b92
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_ad9c3b92=TimeSerLoa_3acc8a8e.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_ad9c3b92=TimeSerLoa_3acc8a8e.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_ad9c3b92=(TimeSerLoa_3acc8a8e.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_ad9c3b92(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-750.0},{-50.0,-730.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_ad9c3b92(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-750.0},{-10.0,-730.0}})));

  //
  // End Component Definitions for ad9c3b92
  //



  //
  // Begin Component Definitions for c7073b9b
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for c7073b9b
  //



  //
  // Begin Component Definitions for 59ecdc88
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_59ecdc88=TimeSerLoa_90fce148.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_59ecdc88=TimeSerLoa_90fce148.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_59ecdc88=-1*(TimeSerLoa_90fce148.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_59ecdc88(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-750.0},{30.0,-730.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_59ecdc88(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-750.0},{70.0,-730.0}})));

  //
  // End Component Definitions for 59ecdc88
  //



  //
  // Begin Component Definitions for a73a5cdd
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for a73a5cdd
  //



  //
  // Begin Component Definitions for b9bbe8b5
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_b9bbe8b5=TimeSerLoa_90fce148.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_b9bbe8b5=TimeSerLoa_90fce148.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_b9bbe8b5=(TimeSerLoa_90fce148.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_b9bbe8b5(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-790.0},{-50.0,-770.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_b9bbe8b5(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-790.0},{-10.0,-770.0}})));

  //
  // End Component Definitions for b9bbe8b5
  //



  //
  // Begin Component Definitions for d1d063dc
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for d1d063dc
  //



equation
  // Connections

  //
  // Begin Connect Statements for 1848589c
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ConnectStatements.mopt
  //

  // TODO: these connect statements shouldn't be here, they are plant specific
  // but since we can't currently make connect statements for single systems, this is what we've got
  connect(on_cooPla_9423f0cc.y,cooPla_9423f0cc.on)
    annotation (Line(points={{61.69330068582781,-759.8705050779631},{41.69330068582781,-759.8705050779631},{41.69330068582781,-739.8705050779631},{41.69330068582781,-719.8705050779631},{41.69330068582781,-699.8705050779631},{41.69330068582781,-679.8705050779631},{41.69330068582781,-659.8705050779631},{41.69330068582781,-639.8705050779631},{41.69330068582781,-619.8705050779631},{41.69330068582781,-599.8705050779631},{41.69330068582781,-579.8705050779631},{41.69330068582781,-559.8705050779631},{41.69330068582781,-539.8705050779631},{41.69330068582781,-519.8705050779631},{41.69330068582781,-499.8705050779631},{41.69330068582781,-479.8705050779631},{41.69330068582781,-459.8705050779631},{41.69330068582781,-439.8705050779631},{41.69330068582781,-419.8705050779631},{41.69330068582781,-399.8705050779631},{41.69330068582781,-379.8705050779631},{41.69330068582781,-359.8705050779631},{41.69330068582781,-339.8705050779631},{41.69330068582781,-319.8705050779631},{41.69330068582781,-299.8705050779631},{41.69330068582781,-279.8705050779631},{41.69330068582781,-259.8705050779631},{41.69330068582781,-239.87050507796312},{41.69330068582781,-219.87050507796312},{41.69330068582781,-199.87050507796312},{41.69330068582781,-179.87050507796312},{41.69330068582781,-159.87050507796312},{41.69330068582781,-139.87050507796312},{41.69330068582781,-119.87050507796312},{41.69330068582781,-99.87050507796312},{41.69330068582781,-79.87050507796312},{41.69330068582781,-59.87050507796312},{41.69330068582781,-39.87050507796312},{41.69330068582781,-19.870505077963116},{41.69330068582781,0.1294949220368835},{41.69330068582781,20.129494922036884},{41.69330068582781,40.12949492203688},{41.69330068582781,60.12949492203688},{41.69330068582781,80.12949492203688},{41.69330068582781,100.12949492203688},{41.69330068582781,120.12949492203688},{41.69330068582781,140.12949492203688},{41.69330068582781,160.12949492203688},{41.69330068582781,180.12949492203688},{41.69330068582781,200.12949492203688},{41.69330068582781,220.12949492203688},{41.69330068582781,240.12949492203688},{41.69330068582781,260.1294949220369},{41.69330068582781,280.1294949220369},{41.69330068582781,300.1294949220369},{41.69330068582781,320.1294949220369},{41.69330068582781,340.1294949220369},{41.69330068582781,360.1294949220369},{41.69330068582781,380.1294949220369},{41.69330068582781,400.1294949220369},{41.69330068582781,420.1294949220369},{41.69330068582781,440.1294949220369},{41.69330068582781,460.1294949220369},{41.69330068582781,480.1294949220369},{41.69330068582781,500.1294949220369},{41.69330068582781,520.1294949220369},{41.69330068582781,540.1294949220369},{41.69330068582781,560.1294949220369},{41.69330068582781,580.1294949220369},{41.69330068582781,600.1294949220369},{41.69330068582781,620.1294949220369},{41.69330068582781,640.1294949220369},{41.69330068582781,660.1294949220369},{41.69330068582781,680.1294949220369},{41.69330068582781,700.1294949220369},{41.69330068582781,720.1294949220369},{41.69330068582781,740.1294949220369},{41.69330068582781,760.1294949220369},{21.693300685827822,760.1294949220369},{1.693300685827822,760.1294949220369},{-18.306699314172178,760.1294949220369},{-38.30669931417218,760.1294949220369},{-38.30669931417218,780.1294949220369},{-58.30669931417218,780.1294949220369}},color={0,0,127}));
  connect(TSetChiWatDis_cooPla_9423f0cc.y,cooPla_9423f0cc.TCHWSupSet)
    annotation (Line(points={{18.919971672091393,-753.9840575414694},{-1.0800283279086074,-753.9840575414694},{-1.0800283279086074,-733.9840575414694},{-1.0800283279086074,-713.9840575414694},{-1.0800283279086074,-693.9840575414694},{-1.0800283279086074,-673.9840575414694},{-1.0800283279086074,-653.9840575414694},{-1.0800283279086074,-633.9840575414694},{-1.0800283279086074,-613.9840575414694},{-1.0800283279086074,-593.9840575414694},{-1.0800283279086074,-573.9840575414694},{-1.0800283279086074,-553.9840575414694},{-1.0800283279086074,-533.9840575414694},{-1.0800283279086074,-513.9840575414694},{-1.0800283279086074,-493.9840575414694},{-1.0800283279086074,-473.9840575414694},{-1.0800283279086074,-453.9840575414694},{-1.0800283279086074,-433.9840575414694},{-1.0800283279086074,-413.9840575414694},{-1.0800283279086074,-393.9840575414694},{-1.0800283279086074,-373.9840575414694},{-1.0800283279086074,-353.9840575414694},{-1.0800283279086074,-333.9840575414694},{-1.0800283279086074,-313.9840575414694},{-1.0800283279086074,-293.9840575414694},{-1.0800283279086074,-273.9840575414694},{-1.0800283279086074,-253.98405754146938},{-1.0800283279086074,-233.98405754146938},{-1.0800283279086074,-213.98405754146938},{-1.0800283279086074,-193.98405754146938},{-1.0800283279086074,-173.98405754146938},{-1.0800283279086074,-153.98405754146938},{-1.0800283279086074,-133.98405754146938},{-1.0800283279086074,-113.98405754146938},{-1.0800283279086074,-93.98405754146938},{-1.0800283279086074,-73.98405754146938},{-1.0800283279086074,-53.98405754146938},{-1.0800283279086074,-33.98405754146938},{-1.0800283279086074,-13.984057541469383},{-1.0800283279086074,6.015942458530617},{-1.0800283279086074,26.015942458530617},{-1.0800283279086074,46.01594245853062},{-1.0800283279086074,66.01594245853062},{-1.0800283279086074,86.01594245853062},{-1.0800283279086074,106.01594245853062},{-1.0800283279086074,126.01594245853062},{-1.0800283279086074,146.01594245853062},{-1.0800283279086074,166.01594245853062},{-1.0800283279086074,186.01594245853062},{-1.0800283279086074,206.01594245853062},{-1.0800283279086074,226.01594245853062},{-1.0800283279086074,246.01594245853062},{-1.0800283279086074,266.0159424585306},{-1.0800283279086074,286.0159424585306},{-1.0800283279086074,306.0159424585306},{-1.0800283279086074,326.0159424585306},{-1.0800283279086074,346.0159424585306},{-1.0800283279086074,366.0159424585306},{-1.0800283279086074,386.0159424585306},{-1.0800283279086074,406.0159424585306},{-1.0800283279086074,426.0159424585306},{-1.0800283279086074,446.0159424585306},{-1.0800283279086074,466.0159424585306},{-1.0800283279086074,486.0159424585306},{-1.0800283279086074,506.0159424585306},{-1.0800283279086074,526.0159424585306},{-1.0800283279086074,546.0159424585306},{-1.0800283279086074,566.0159424585306},{-1.0800283279086074,586.0159424585306},{-1.0800283279086074,606.0159424585306},{-1.0800283279086074,626.0159424585306},{-1.0800283279086074,646.0159424585306},{-1.0800283279086074,666.0159424585306},{-1.0800283279086074,686.0159424585306},{-1.0800283279086074,706.0159424585306},{-1.0800283279086074,726.0159424585306},{-1.0800283279086074,746.0159424585306},{-1.0800283279086074,766.0159424585306},{-21.080028327908607,766.0159424585306},{-41.08002832790861,766.0159424585306},{-41.08002832790861,786.0159424585306},{-61.08002832790861,786.0159424585306}},color={0,0,127}));

  connect(disNet_a752939f.port_bDisRet,cooPla_9423f0cc.port_a)
    annotation (Line(points={{-35.586656490109554,781.4183977163904},{-55.586656490109554,781.4183977163904}},color={0,0,127}));
  connect(cooPla_9423f0cc.port_b,disNet_a752939f.port_aDisSup)
    annotation (Line(points={{-36.47376323838288,774.5414365601432},{-16.473763238382887,774.5414365601432}},color={0,0,127}));
  connect(disNet_a752939f.dp,cooPla_9423f0cc.dpMea)
    annotation (Line(points={{-47.638419327994136,772.7887571943963},{-67.63841932799414,772.7887571943963}},color={0,0,127}));

  //
  // End Connect Statements for 1848589c
  //



  //
  // Begin Connect Statements for 157e41f2
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ConnectStatements.mopt
  //

  connect(heaPlafa600d24.port_a,disNet_2feea5e7.port_bDisRet)
    annotation (Line(points={{-34.40808143832259,732.5511960740478},{-14.408081438322597,732.5511960740478}},color={0,0,127}));
  connect(disNet_2feea5e7.dp,heaPlafa600d24.dpMea)
    annotation (Line(points={{-35.18075507208755,743.2091423868374},{-55.18075507208755,743.2091423868374}},color={0,0,127}));
  connect(heaPlafa600d24.port_b,disNet_2feea5e7.port_aDisSup)
    annotation (Line(points={{-32.40529550295763,748.4139613659838},{-12.405295502957628,748.4139613659838}},color={0,0,127}));
  connect(mPum_flow_157e41f2.y,heaPlafa600d24.on)
    annotation (Line(points={{-55.21644435758715,-244.60891049269458},{-55.21644435758715,-224.60891049269458},{-55.21644435758715,-204.60891049269458},{-55.21644435758715,-184.60891049269458},{-55.21644435758715,-164.60891049269458},{-55.21644435758715,-144.60891049269458},{-55.21644435758715,-124.60891049269458},{-55.21644435758715,-104.60891049269458},{-55.21644435758715,-84.60891049269458},{-55.21644435758715,-64.60891049269458},{-55.21644435758715,-44.60891049269458},{-55.21644435758715,-24.608910492694577},{-55.21644435758715,-4.6089104926945765},{-55.21644435758715,15.391089507305423},{-55.21644435758715,35.39108950730542},{-55.21644435758715,55.39108950730542},{-55.21644435758715,75.39108950730542},{-55.21644435758715,95.39108950730542},{-55.21644435758715,115.39108950730542},{-55.21644435758715,135.39108950730542},{-55.21644435758715,155.39108950730542},{-55.21644435758715,175.39108950730542},{-55.21644435758715,195.39108950730542},{-55.21644435758715,215.39108950730542},{-55.21644435758715,235.39108950730542},{-55.21644435758715,255.39108950730542},{-55.21644435758715,275.3910895073054},{-55.21644435758715,295.3910895073054},{-55.21644435758715,315.3910895073055},{-55.21644435758715,335.3910895073055},{-55.21644435758715,355.3910895073055},{-55.21644435758715,375.3910895073055},{-55.21644435758715,395.3910895073055},{-55.21644435758715,415.3910895073055},{-55.21644435758715,435.3910895073055},{-55.21644435758715,455.3910895073055},{-55.21644435758715,475.3910895073055},{-55.21644435758715,495.3910895073055},{-55.21644435758715,515.3910895073054},{-55.21644435758715,535.3910895073054},{-55.21644435758715,555.3910895073054},{-55.21644435758715,575.3910895073054},{-55.21644435758715,595.3910895073054},{-55.21644435758715,615.3910895073054},{-55.21644435758715,635.3910895073054},{-55.21644435758715,655.3910895073054},{-55.21644435758715,675.3910895073054},{-55.21644435758715,695.3910895073054},{-55.21644435758715,715.3910895073054},{-55.21644435758715,735.3910895073054}},color={0,0,127}));
  connect(TDisSetHeaWat_157e41f2.y,heaPlafa600d24.THeaSet)
    annotation (Line(points={{-14.071706766005292,-244.52036789251042},{-14.071706766005292,-224.52036789251042},{-14.071706766005292,-204.5203678925103},{-14.071706766005292,-184.5203678925103},{-14.071706766005292,-164.5203678925103},{-14.071706766005292,-144.5203678925103},{-14.071706766005292,-124.52036789251031},{-14.071706766005292,-104.52036789251031},{-14.071706766005292,-84.52036789251031},{-14.071706766005292,-64.52036789251031},{-14.071706766005292,-44.52036789251031},{-14.071706766005292,-24.520367892510308},{-14.071706766005292,-4.520367892510308},{-14.071706766005292,15.479632107489692},{-14.071706766005292,35.47963210748969},{-14.071706766005292,55.47963210748969},{-14.071706766005292,75.47963210748969},{-14.071706766005292,95.47963210748969},{-14.071706766005292,115.47963210748969},{-14.071706766005292,135.4796321074897},{-14.071706766005292,155.4796321074897},{-14.071706766005292,175.4796321074897},{-14.071706766005292,195.4796321074897},{-14.071706766005292,215.4796321074897},{-14.071706766005292,235.4796321074897},{-14.071706766005292,255.4796321074897},{-14.071706766005292,275.4796321074897},{-14.071706766005292,295.4796321074897},{-14.071706766005292,315.4796321074897},{-14.071706766005292,335.4796321074897},{-14.071706766005292,355.4796321074897},{-14.071706766005292,375.4796321074897},{-14.071706766005292,395.4796321074897},{-14.071706766005292,415.4796321074897},{-14.071706766005292,435.4796321074897},{-14.071706766005292,455.4796321074897},{-14.071706766005292,475.4796321074897},{-14.071706766005292,495.4796321074897},{-14.071706766005292,515.4796321074897},{-14.071706766005292,535.4796321074897},{-14.071706766005292,555.4796321074897},{-14.071706766005292,575.4796321074897},{-14.071706766005292,595.4796321074897},{-14.071706766005292,615.4796321074897},{-14.071706766005292,635.4796321074897},{-14.071706766005292,655.4796321074897},{-14.071706766005292,675.4796321074897},{-14.071706766005292,695.4796321074897},{-14.071706766005292,715.4796321074897},{-34.071706766005285,715.4796321074897},{-34.071706766005285,735.4796321074897},{-54.071706766005285,735.4796321074897}},color={0,0,127}));

  //
  // End Connect Statements for 157e41f2
  //



  //
  // Begin Connect Statements for 368e0093
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_377d8bff.ports_bChiWat[1], cooInd_3c4c4b87.port_a2)
    annotation (Line(points={{52.881852097153114,757.5788869016006},{52.881852097153114,737.5788869016006},{32.8818520971531,737.5788869016006},{12.8818520971531,737.5788869016006}},color={0,0,127}));
  connect(cooInd_3c4c4b87.port_b2,TimeSerLoa_377d8bff.ports_aChiWat[1])
    annotation (Line(points={{15.289912936779942,765.4377519670323},{35.28991293677994,765.4377519670323},{35.28991293677994,785.4377519670323},{55.28991293677993,785.4377519670323}},color={0,0,127}));
  connect(pressure_source_368e0093.ports[1], cooInd_3c4c4b87.port_b2)
    annotation (Line(points={{19.66636159709725,-247.27959642543942},{-0.33363840290274993,-247.27959642543942},{-0.33363840290274993,-227.27959642543942},{-0.33363840290274993,-207.2795964254393},{-0.33363840290274993,-187.2795964254393},{-0.33363840290274993,-167.2795964254393},{-0.33363840290274993,-147.2795964254393},{-0.33363840290274993,-127.27959642543931},{-0.33363840290274993,-107.27959642543931},{-0.33363840290274993,-87.27959642543931},{-0.33363840290274993,-67.27959642543931},{-0.33363840290274993,-47.27959642543931},{-0.33363840290274993,-27.27959642543931},{-0.33363840290274993,-7.279596425439308},{-0.33363840290274993,12.720403574560692},{-0.33363840290274993,32.72040357456069},{-0.33363840290274993,52.72040357456069},{-0.33363840290274993,72.72040357456069},{-0.33363840290274993,92.72040357456069},{-0.33363840290274993,112.72040357456069},{-0.33363840290274993,132.7204035745607},{-0.33363840290274993,152.7204035745607},{-0.33363840290274993,172.7204035745607},{-0.33363840290274993,192.7204035745607},{-0.33363840290274993,212.7204035745607},{-0.33363840290274993,232.7204035745607},{-0.33363840290274993,252.7204035745607},{-0.33363840290274993,272.7204035745607},{-0.33363840290274993,292.7204035745607},{-0.33363840290274993,312.7204035745607},{-0.33363840290274993,332.7204035745607},{-0.33363840290274993,352.7204035745607},{-0.33363840290274993,372.7204035745607},{-0.33363840290274993,392.7204035745607},{-0.33363840290274993,412.7204035745607},{-0.33363840290274993,432.7204035745607},{-0.33363840290274993,452.7204035745607},{-0.33363840290274993,472.7204035745607},{-0.33363840290274993,492.7204035745607},{-0.33363840290274993,512.7204035745607},{-0.33363840290274993,532.7204035745607},{-0.33363840290274993,552.7204035745607},{-0.33363840290274993,572.7204035745607},{-0.33363840290274993,592.7204035745607},{-0.33363840290274993,612.7204035745607},{-0.33363840290274993,632.7204035745607},{-0.33363840290274993,652.7204035745607},{-0.33363840290274993,672.7204035745607},{-0.33363840290274993,692.7204035745607},{-0.33363840290274993,712.7204035745607},{-0.33363840290274993,732.7204035745607},{19.66636159709725,732.7204035745607}},color={0,0,127}));
  connect(TChiWatSet_368e0093.y,cooInd_3c4c4b87.TSetBuiSup)
    annotation (Line(points={{61.276668024544904,-230.34802208662813},{61.276668024544904,-210.34802208662813},{61.276668024544904,-190.34802208662813},{41.276668024544904,-190.34802208662813},{41.276668024544904,-170.34802208662813},{41.276668024544904,-150.34802208662813},{41.276668024544904,-130.34802208662813},{41.276668024544904,-110.34802208662813},{41.276668024544904,-90.34802208662813},{41.276668024544904,-70.34802208662813},{41.276668024544904,-50.348022086628134},{41.276668024544904,-30.348022086628134},{41.276668024544904,-10.348022086628134},{41.276668024544904,9.651977913371866},{41.276668024544904,29.651977913371866},{41.276668024544904,49.651977913371866},{41.276668024544904,69.65197791337187},{41.276668024544904,89.65197791337187},{41.276668024544904,109.65197791337187},{41.276668024544904,129.65197791337187},{41.276668024544904,149.65197791337187},{41.276668024544904,169.65197791337187},{41.276668024544904,189.65197791337187},{41.276668024544904,209.65197791337187},{41.276668024544904,229.65197791337187},{41.276668024544904,249.65197791337187},{41.276668024544904,269.65197791337187},{41.276668024544904,289.65197791337187},{41.276668024544904,309.6519779133718},{41.276668024544904,329.6519779133718},{41.276668024544904,349.6519779133718},{41.276668024544904,369.6519779133718},{41.276668024544904,389.6519779133718},{41.276668024544904,409.6519779133718},{41.276668024544904,429.6519779133718},{41.276668024544904,449.6519779133718},{41.276668024544904,469.6519779133718},{41.276668024544904,489.6519779133718},{41.276668024544904,509.6519779133718},{41.276668024544904,529.6519779133719},{41.276668024544904,549.6519779133719},{41.276668024544904,569.6519779133719},{41.276668024544904,589.6519779133719},{41.276668024544904,609.6519779133719},{41.276668024544904,629.6519779133719},{41.276668024544904,649.6519779133719},{41.276668024544904,669.6519779133719},{41.276668024544904,689.6519779133719},{41.276668024544904,709.6519779133719},{41.276668024544904,729.6519779133719},{41.276668024544904,749.6519779133719},{41.276668024544904,769.6519779133719},{41.276668024544904,789.6519779133719},{61.276668024544904,789.6519779133719}},color={0,0,127}));

  //
  // End Connect Statements for 368e0093
  //



  //
  // Begin Connect Statements for c90313cc
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[1],cooInd_3c4c4b87.port_a1)
    annotation (Line(points={{-23.092003629554497,752.1999714522392},{-3.0920036295544975,752.1999714522392},{-3.0920036295544975,732.1999714522392},{16.907996370445503,732.1999714522392}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[1],cooInd_3c4c4b87.port_b1)
    annotation (Line(points={{-24.65786220289708,752.9865211817036},{-4.657862202897078,752.9865211817036},{-4.657862202897078,732.9865211817036},{15.342137797102922,732.9865211817036}},color={0,0,127}));

  //
  // End Connect Statements for c90313cc
  //



  //
  // Begin Connect Statements for f0c49fa9
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_377d8bff.ports_bHeaWat[1], heaInd_0524babc.port_a2)
    annotation (Line(points={{47.99412346270674,784.3551402595278},{27.994123462706725,784.3551402595278}},color={0,0,127}));
  connect(heaInd_0524babc.port_b2,TimeSerLoa_377d8bff.ports_aHeaWat[1])
    annotation (Line(points={{35.725034220276626,777.3398462831728},{55.725034220276626,777.3398462831728}},color={0,0,127}));
  connect(pressure_source_f0c49fa9.ports[1], heaInd_0524babc.port_b2)
    annotation (Line(points={{-61.466057962293995,-278.5376294892892},{-41.466057962293995,-278.5376294892892},{-41.466057962293995,-258.5376294892892},{-41.466057962293995,-238.5376294892892},{-41.466057962293995,-218.5376294892892},{-41.466057962293995,-198.53762948928932},{-41.466057962293995,-178.53762948928932},{-41.466057962293995,-158.53762948928932},{-41.466057962293995,-138.53762948928932},{-41.466057962293995,-118.53762948928932},{-41.466057962293995,-98.53762948928932},{-41.466057962293995,-78.53762948928932},{-41.466057962293995,-58.537629489289316},{-41.466057962293995,-38.537629489289316},{-41.466057962293995,-18.537629489289316},{-41.466057962293995,1.4623705107106844},{-41.466057962293995,21.462370510710684},{-41.466057962293995,41.462370510710684},{-41.466057962293995,61.462370510710684},{-41.466057962293995,81.46237051071068},{-41.466057962293995,101.46237051071068},{-41.466057962293995,121.46237051071068},{-41.466057962293995,141.46237051071068},{-41.466057962293995,161.46237051071068},{-41.466057962293995,181.46237051071068},{-41.466057962293995,201.46237051071068},{-41.466057962293995,221.46237051071068},{-41.466057962293995,241.46237051071068},{-41.466057962293995,261.4623705107107},{-41.466057962293995,281.4623705107107},{-41.466057962293995,301.46237051071074},{-41.466057962293995,321.46237051071074},{-41.466057962293995,341.46237051071074},{-41.466057962293995,361.46237051071074},{-41.466057962293995,381.46237051071074},{-41.466057962293995,401.46237051071074},{-41.466057962293995,421.46237051071074},{-41.466057962293995,441.46237051071074},{-41.466057962293995,461.46237051071074},{-41.466057962293995,481.46237051071074},{-41.466057962293995,501.46237051071074},{-41.466057962293995,521.4623705107108},{-41.466057962293995,541.4623705107108},{-41.466057962293995,561.4623705107108},{-41.466057962293995,581.4623705107108},{-41.466057962293995,601.4623705107108},{-41.466057962293995,621.4623705107108},{-41.466057962293995,641.4623705107108},{-41.466057962293995,661.4623705107108},{-41.466057962293995,681.4623705107108},{-41.466057962293995,701.4623705107108},{-41.466057962293995,721.4623705107108},{-41.466057962293995,741.4623705107108},{-41.466057962293995,761.4623705107107},{-21.466057962294002,761.4623705107107},{-1.466057962294002,761.4623705107107},{-1.466057962294002,781.4623705107107},{18.533942037705998,781.4623705107107}},color={0,0,127}));
  connect(THeaWatSet_f0c49fa9.y,heaInd_0524babc.TSetBuiSup)
    annotation (Line(points={{-29.15631424373568,-273.9497859081441},{-9.156314243735679,-273.9497859081441},{-9.156314243735679,-253.94978590814412},{-9.156314243735679,-233.94978590814412},{-9.156314243735679,-213.94978590814412},{-9.156314243735679,-193.94978590814412},{-9.156314243735679,-173.94978590814412},{-9.156314243735679,-153.94978590814412},{-9.156314243735679,-133.94978590814412},{-9.156314243735679,-113.94978590814412},{-9.156314243735679,-93.94978590814412},{-9.156314243735679,-73.94978590814412},{-9.156314243735679,-53.94978590814412},{-9.156314243735679,-33.94978590814412},{-9.156314243735679,-13.949785908144122},{-9.156314243735679,6.050214091855878},{-9.156314243735679,26.050214091855878},{-9.156314243735679,46.05021409185588},{-9.156314243735679,66.05021409185588},{-9.156314243735679,86.05021409185588},{-9.156314243735679,106.05021409185588},{-9.156314243735679,126.05021409185588},{-9.156314243735679,146.05021409185588},{-9.156314243735679,166.05021409185588},{-9.156314243735679,186.05021409185588},{-9.156314243735679,206.05021409185588},{-9.156314243735679,226.05021409185588},{-9.156314243735679,246.05021409185588},{-9.156314243735679,266.0502140918559},{-9.156314243735679,286.0502140918559},{-9.156314243735679,306.0502140918559},{-9.156314243735679,326.0502140918559},{-9.156314243735679,346.0502140918559},{-9.156314243735679,366.0502140918559},{-9.156314243735679,386.0502140918559},{-9.156314243735679,406.0502140918559},{-9.156314243735679,426.0502140918559},{-9.156314243735679,446.0502140918559},{-9.156314243735679,466.0502140918559},{-9.156314243735679,486.0502140918559},{-9.156314243735679,506.0502140918559},{-9.156314243735679,526.0502140918559},{-9.156314243735679,546.0502140918559},{-9.156314243735679,566.0502140918559},{-9.156314243735679,586.0502140918559},{-9.156314243735679,606.0502140918559},{-9.156314243735679,626.0502140918559},{-9.156314243735679,646.0502140918559},{-9.156314243735679,666.0502140918559},{-9.156314243735679,686.0502140918559},{-9.156314243735679,706.0502140918559},{-9.156314243735679,726.0502140918559},{-9.156314243735679,746.0502140918559},{-9.156314243735679,766.0502140918559},{-9.156314243735679,786.0502140918559},{10.843685756264321,786.0502140918559}},color={0,0,127}));

  //
  // End Connect Statements for f0c49fa9
  //



  //
  // Begin Connect Statements for 4664b4f7
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[1],heaInd_0524babc.port_a1)
    annotation (Line(points={{-12.884487399842556,759.4821015466196},{7.1155126001574445,759.4821015466196},{7.1155126001574445,779.4821015466196},{27.115512600157444,779.4821015466196}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[1],heaInd_0524babc.port_b1)
    annotation (Line(points={{-25.168608582150057,752.5551703235856},{-5.168608582150057,752.5551703235856},{-5.168608582150057,772.5551703235856},{14.831391417849943,772.5551703235856}},color={0,0,127}));

  //
  // End Connect Statements for 4664b4f7
  //



  //
  // Begin Connect Statements for 90a17de7
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_0f322c95.ports_bChiWat[1], cooInd_b5a76684.port_a2)
    annotation (Line(points={{43.26708338804167,704.7302117096812},{23.26708338804167,704.7302117096812}},color={0,0,127}));
  connect(cooInd_b5a76684.port_b2,TimeSerLoa_0f322c95.ports_aChiWat[1])
    annotation (Line(points={{46.247215676419245,698.0078472436998},{66.24721567641924,698.0078472436998}},color={0,0,127}));
  connect(pressure_source_90a17de7.ports[1], cooInd_b5a76684.port_b2)
    annotation (Line(points={{15.332374776141563,-270.31823948296073},{-4.667625223858437,-270.31823948296073},{-4.667625223858437,-250.31823948296073},{-4.667625223858437,-230.31823948296073},{-4.667625223858437,-210.31823948296062},{-4.667625223858437,-190.31823948296062},{-4.667625223858437,-170.31823948296062},{-4.667625223858437,-150.31823948296062},{-4.667625223858437,-130.31823948296062},{-4.667625223858437,-110.31823948296062},{-4.667625223858437,-90.31823948296062},{-4.667625223858437,-70.31823948296062},{-4.667625223858437,-50.31823948296062},{-4.667625223858437,-30.31823948296062},{-4.667625223858437,-10.318239482960621},{-4.667625223858437,9.681760517039379},{-4.667625223858437,29.68176051703938},{-4.667625223858437,49.68176051703938},{-4.667625223858437,69.68176051703938},{-4.667625223858437,89.68176051703938},{-4.667625223858437,109.68176051703938},{-4.667625223858437,129.68176051703938},{-4.667625223858437,149.68176051703938},{-4.667625223858437,169.68176051703938},{-4.667625223858437,189.68176051703938},{-4.667625223858437,209.68176051703938},{-4.667625223858437,229.68176051703938},{-4.667625223858437,249.68176051703938},{-4.667625223858437,269.6817605170394},{-4.667625223858437,289.6817605170394},{-4.667625223858437,309.6817605170394},{-4.667625223858437,329.6817605170394},{-4.667625223858437,349.6817605170394},{-4.667625223858437,369.6817605170394},{-4.667625223858437,389.6817605170394},{-4.667625223858437,409.6817605170394},{-4.667625223858437,429.6817605170394},{-4.667625223858437,449.6817605170394},{-4.667625223858437,469.6817605170394},{-4.667625223858437,489.6817605170394},{-4.667625223858437,509.6817605170394},{-4.667625223858437,529.6817605170394},{-4.667625223858437,549.6817605170394},{-4.667625223858437,569.6817605170394},{-4.667625223858437,589.6817605170394},{-4.667625223858437,609.6817605170394},{-4.667625223858437,629.6817605170394},{-4.667625223858437,649.6817605170394},{-4.667625223858437,669.6817605170394},{-4.667625223858437,689.6817605170394},{-4.667625223858437,709.6817605170394},{15.332374776141563,709.6817605170394}},color={0,0,127}));
  connect(TChiWatSet_90a17de7.y,cooInd_b5a76684.TSetBuiSup)
    annotation (Line(points={{66.46326609222498,-275.5723210118033},{46.463266092224984,-275.5723210118033},{46.463266092224984,-255.5723210118033},{46.463266092224984,-235.5723210118033},{46.463266092224984,-215.5723210118033},{46.463266092224984,-195.5723210118033},{46.463266092224984,-175.5723210118033},{46.463266092224984,-155.5723210118033},{46.463266092224984,-135.5723210118033},{46.463266092224984,-115.5723210118033},{46.463266092224984,-95.5723210118033},{46.463266092224984,-75.5723210118033},{46.463266092224984,-55.5723210118033},{46.463266092224984,-35.5723210118033},{46.463266092224984,-15.572321011803297},{46.463266092224984,4.427678988196703},{46.463266092224984,24.427678988196703},{46.463266092224984,44.4276789881967},{46.463266092224984,64.4276789881967},{46.463266092224984,84.4276789881967},{46.463266092224984,104.4276789881967},{46.463266092224984,124.4276789881967},{46.463266092224984,144.4276789881967},{46.463266092224984,164.4276789881967},{46.463266092224984,184.4276789881967},{46.463266092224984,204.4276789881967},{46.463266092224984,224.4276789881967},{46.463266092224984,244.4276789881967},{46.463266092224984,264.4276789881967},{46.463266092224984,284.4276789881967},{46.463266092224984,304.4276789881967},{46.463266092224984,324.4276789881967},{46.463266092224984,344.4276789881967},{46.463266092224984,364.4276789881967},{46.463266092224984,384.4276789881967},{46.463266092224984,404.4276789881967},{46.463266092224984,424.4276789881967},{46.463266092224984,444.4276789881967},{46.463266092224984,464.4276789881967},{46.463266092224984,484.4276789881967},{46.463266092224984,504.4276789881967},{46.463266092224984,524.4276789881967},{46.463266092224984,544.4276789881967},{46.463266092224984,564.4276789881967},{46.463266092224984,584.4276789881967},{46.463266092224984,604.4276789881967},{46.463266092224984,624.4276789881967},{46.463266092224984,644.4276789881967},{46.463266092224984,664.4276789881967},{46.463266092224984,684.4276789881967},{46.463266092224984,704.4276789881967},{66.46326609222498,704.4276789881967}},color={0,0,127}));

  //
  // End Connect Statements for 90a17de7
  //



  //
  // Begin Connect Statements for 34d9fa3f
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[2],cooInd_b5a76684.port_a1)
    annotation (Line(points={{-18.514706831089015,752.4414747189307},{1.4852931689109852,752.4414747189307},{1.4852931689109852,732.4414747189307},{1.4852931689109852,712.4414747189307},{1.4852931689109852,692.4414747189307},{21.485293168910985,692.4414747189307}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[2],cooInd_b5a76684.port_b1)
    annotation (Line(points={{-28.176256023874892,755.9387778505933},{-8.176256023874885,755.9387778505933},{-8.176256023874885,735.9387778505933},{-8.176256023874885,715.9387778505933},{-8.176256023874885,695.9387778505933},{11.823743976125115,695.9387778505933}},color={0,0,127}));

  //
  // End Connect Statements for 34d9fa3f
  //



  //
  // Begin Connect Statements for 27e45984
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_0f322c95.ports_bHeaWat[1], heaInd_34e2d2aa.port_a2)
    annotation (Line(points={{67.51756589154911,682.790387308677},{67.51756589154911,662.790387308677},{47.51756589154911,662.790387308677},{27.517565891549097,662.790387308677}},color={0,0,127}));
  connect(heaInd_34e2d2aa.port_b2,TimeSerLoa_0f322c95.ports_aHeaWat[1])
    annotation (Line(points={{19.170767087903556,689.3393320055432},{39.170767087903556,689.3393320055432},{39.170767087903556,709.3393320055432},{59.170767087903556,709.3393320055432}},color={0,0,127}));
  connect(pressure_source_27e45984.ports[1], heaInd_34e2d2aa.port_b2)
    annotation (Line(points={{-59.53497456763397,-315.89209235336943},{-39.53497456763397,-315.89209235336943},{-39.53497456763397,-295.89209235336943},{-39.53497456763397,-275.89209235336943},{-39.53497456763397,-255.89209235336943},{-39.53497456763397,-235.89209235336943},{-39.53497456763397,-215.89209235336943},{-39.53497456763397,-195.89209235336943},{-39.53497456763397,-175.89209235336943},{-39.53497456763397,-155.89209235336943},{-39.53497456763397,-135.89209235336943},{-39.53497456763397,-115.89209235336943},{-39.53497456763397,-95.89209235336943},{-39.53497456763397,-75.89209235336943},{-39.53497456763397,-55.892092353369435},{-39.53497456763397,-35.892092353369435},{-39.53497456763397,-15.892092353369435},{-39.53497456763397,4.107907646630565},{-39.53497456763397,24.107907646630565},{-39.53497456763397,44.107907646630565},{-39.53497456763397,64.10790764663057},{-39.53497456763397,84.10790764663057},{-39.53497456763397,104.10790764663057},{-39.53497456763397,124.10790764663057},{-39.53497456763397,144.10790764663057},{-39.53497456763397,164.10790764663057},{-39.53497456763397,184.10790764663057},{-39.53497456763397,204.10790764663057},{-39.53497456763397,224.10790764663057},{-39.53497456763397,244.10790764663057},{-39.53497456763397,264.10790764663057},{-39.53497456763397,284.10790764663057},{-39.53497456763397,304.1079076466306},{-39.53497456763397,324.1079076466306},{-39.53497456763397,344.1079076466306},{-39.53497456763397,364.1079076466306},{-39.53497456763397,384.1079076466306},{-39.53497456763397,404.1079076466306},{-39.53497456763397,424.1079076466306},{-39.53497456763397,444.1079076466306},{-39.53497456763397,464.1079076466306},{-39.53497456763397,484.1079076466306},{-39.53497456763397,504.1079076466306},{-39.53497456763397,524.1079076466306},{-39.53497456763397,544.1079076466306},{-39.53497456763397,564.1079076466306},{-39.53497456763397,584.1079076466306},{-39.53497456763397,604.1079076466306},{-39.53497456763397,624.1079076466306},{-39.53497456763397,644.1079076466306},{-39.53497456763397,664.1079076466306},{-19.534974567633967,664.1079076466306},{0.46502543236603344,664.1079076466306},{20.465025432366033,664.1079076466306}},color={0,0,127}));
  connect(THeaWatSet_27e45984.y,heaInd_34e2d2aa.TSetBuiSup)
    annotation (Line(points={{-27.49269347113001,-325.4692863272294},{-7.492693471130011,-325.4692863272294},{-7.492693471130011,-305.4692863272294},{-7.492693471130011,-285.4692863272294},{-7.492693471130011,-265.4692863272294},{-7.492693471130011,-245.46928632722938},{-7.492693471130011,-225.46928632722938},{-7.492693471130011,-205.46928632722938},{-7.492693471130011,-185.46928632722938},{-7.492693471130011,-165.46928632722938},{-7.492693471130011,-145.46928632722938},{-7.492693471130011,-125.46928632722938},{-7.492693471130011,-105.46928632722938},{-7.492693471130011,-85.46928632722938},{-7.492693471130011,-65.46928632722938},{-7.492693471130011,-45.46928632722938},{-7.492693471130011,-25.469286327229383},{-7.492693471130011,-5.4692863272293835},{-7.492693471130011,14.530713672770617},{-7.492693471130011,34.53071367277062},{-7.492693471130011,54.53071367277062},{-7.492693471130011,74.53071367277062},{-7.492693471130011,94.53071367277062},{-7.492693471130011,114.53071367277062},{-7.492693471130011,134.53071367277062},{-7.492693471130011,154.53071367277062},{-7.492693471130011,174.53071367277062},{-7.492693471130011,194.53071367277062},{-7.492693471130011,214.53071367277062},{-7.492693471130011,234.53071367277062},{-7.492693471130011,254.53071367277062},{-7.492693471130011,274.5307136727706},{-7.492693471130011,294.5307136727706},{-7.492693471130011,314.5307136727706},{-7.492693471130011,334.5307136727706},{-7.492693471130011,354.5307136727706},{-7.492693471130011,374.5307136727706},{-7.492693471130011,394.5307136727706},{-7.492693471130011,414.5307136727706},{-7.492693471130011,434.5307136727706},{-7.492693471130011,454.5307136727706},{-7.492693471130011,474.5307136727706},{-7.492693471130011,494.5307136727706},{-7.492693471130011,514.5307136727706},{-7.492693471130011,534.5307136727706},{-7.492693471130011,554.5307136727706},{-7.492693471130011,574.5307136727706},{-7.492693471130011,594.5307136727706},{-7.492693471130011,614.5307136727706},{-7.492693471130011,634.5307136727706},{-7.492693471130011,654.5307136727706},{12.50730652886999,654.5307136727706}},color={0,0,127}));

  //
  // End Connect Statements for 27e45984
  //



  //
  // Begin Connect Statements for 184b10e5
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[2],heaInd_34e2d2aa.port_a1)
    annotation (Line(points={{-17.537739020369443,711.8428167923695},{-17.537739020369443,691.8428167923695},{-17.537739020369443,671.8428167923695},{-17.537739020369443,651.8428167923695},{2.462260979630557,651.8428167923695},{22.462260979630557,651.8428167923695}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[2],heaInd_34e2d2aa.port_b1)
    annotation (Line(points={{-23.376966460710648,722.8087367552155},{-23.376966460710648,702.8087367552155},{-23.376966460710648,682.8087367552155},{-23.376966460710648,662.8087367552155},{-3.3769664607106478,662.8087367552155},{16.623033539289352,662.8087367552155}},color={0,0,127}));

  //
  // End Connect Statements for 184b10e5
  //



  //
  // Begin Connect Statements for e2766992
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_70d22094.ports_bChiWat[1], cooInd_f20214bc.port_a2)
    annotation (Line(points={{52.42211503108396,607.3404146505488},{52.42211503108396,587.3404146505488},{32.42211503108396,587.3404146505488},{12.422115031083962,587.3404146505488}},color={0,0,127}));
  connect(cooInd_f20214bc.port_b2,TimeSerLoa_70d22094.ports_aChiWat[1])
    annotation (Line(points={{18.30712995934155,593.2618628336186},{38.30712995934155,593.2618628336186},{38.30712995934155,613.2618628336186},{58.30712995934155,613.2618628336186}},color={0,0,127}));
  connect(pressure_source_e2766992.ports[1], cooInd_f20214bc.port_b2)
    annotation (Line(points={{17.714916605883758,-314.44601626712915},{-2.285083394116242,-314.44601626712915},{-2.285083394116242,-294.44601626712915},{-2.285083394116242,-274.44601626712915},{-2.285083394116242,-254.44601626712915},{-2.285083394116242,-234.44601626712915},{-2.285083394116242,-214.44601626712915},{-2.285083394116242,-194.44601626712915},{-2.285083394116242,-174.44601626712915},{-2.285083394116242,-154.44601626712915},{-2.285083394116242,-134.44601626712915},{-2.285083394116242,-114.44601626712915},{-2.285083394116242,-94.44601626712915},{-2.285083394116242,-74.44601626712915},{-2.285083394116242,-54.44601626712915},{-2.285083394116242,-34.44601626712915},{-2.285083394116242,-14.446016267129153},{-2.285083394116242,5.553983732870847},{-2.285083394116242,25.553983732870847},{-2.285083394116242,45.55398373287085},{-2.285083394116242,65.55398373287085},{-2.285083394116242,85.55398373287085},{-2.285083394116242,105.55398373287085},{-2.285083394116242,125.55398373287085},{-2.285083394116242,145.55398373287085},{-2.285083394116242,165.55398373287085},{-2.285083394116242,185.55398373287085},{-2.285083394116242,205.55398373287085},{-2.285083394116242,225.55398373287085},{-2.285083394116242,245.55398373287085},{-2.285083394116242,265.55398373287085},{-2.285083394116242,285.55398373287085},{-2.285083394116242,305.5539837328709},{-2.285083394116242,325.5539837328709},{-2.285083394116242,345.5539837328709},{-2.285083394116242,365.5539837328709},{-2.285083394116242,385.5539837328709},{-2.285083394116242,405.5539837328709},{-2.285083394116242,425.5539837328709},{-2.285083394116242,445.5539837328709},{-2.285083394116242,465.5539837328709},{-2.285083394116242,485.5539837328709},{-2.285083394116242,505.5539837328709},{-2.285083394116242,525.5539837328708},{-2.285083394116242,545.5539837328708},{-2.285083394116242,565.5539837328708},{-2.285083394116242,585.5539837328708},{17.714916605883758,585.5539837328708}},color={0,0,127}));
  connect(TChiWatSet_e2766992.y,cooInd_f20214bc.TSetBuiSup)
    annotation (Line(points={{55.57798300811626,-329.0576020310591},{35.57798300811625,-329.0576020310591},{35.57798300811625,-309.0576020310591},{35.57798300811625,-289.0576020310591},{35.57798300811625,-269.0576020310591},{35.57798300811625,-249.0576020310591},{35.57798300811625,-229.0576020310591},{35.57798300811625,-209.0576020310591},{35.57798300811625,-189.0576020310591},{35.57798300811625,-169.0576020310591},{35.57798300811625,-149.0576020310591},{35.57798300811625,-129.0576020310591},{35.57798300811625,-109.0576020310591},{35.57798300811625,-89.0576020310591},{35.57798300811625,-69.0576020310591},{35.57798300811625,-49.057602031059105},{35.57798300811625,-29.057602031059105},{35.57798300811625,-9.057602031059105},{35.57798300811625,10.942397968940895},{35.57798300811625,30.942397968940895},{35.57798300811625,50.942397968940895},{35.57798300811625,70.9423979689409},{35.57798300811625,90.9423979689409},{35.57798300811625,110.9423979689409},{35.57798300811625,130.9423979689409},{35.57798300811625,150.9423979689409},{35.57798300811625,170.9423979689409},{35.57798300811625,190.9423979689409},{35.57798300811625,210.9423979689409},{35.57798300811625,230.9423979689409},{35.57798300811625,250.9423979689409},{35.57798300811625,270.9423979689409},{35.57798300811625,290.9423979689409},{35.57798300811625,310.94239796894084},{35.57798300811625,330.94239796894084},{35.57798300811625,350.94239796894084},{35.57798300811625,370.94239796894084},{35.57798300811625,390.94239796894084},{35.57798300811625,410.94239796894084},{35.57798300811625,430.94239796894084},{35.57798300811625,450.94239796894084},{35.57798300811625,470.94239796894084},{35.57798300811625,490.94239796894084},{35.57798300811625,510.94239796894084},{35.57798300811625,530.9423979689409},{35.57798300811625,550.9423979689409},{35.57798300811625,570.9423979689409},{35.57798300811625,590.9423979689409},{35.57798300811625,610.9423979689409},{55.57798300811626,610.9423979689409}},color={0,0,127}));

  //
  // End Connect Statements for e2766992
  //



  //
  // Begin Connect Statements for 92e8bd11
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[3],cooInd_f20214bc.port_a1)
    annotation (Line(points={{-19.421466282556082,761.483615178642},{0.5785337174439178,761.483615178642},{0.5785337174439178,741.483615178642},{0.5785337174439178,721.483615178642},{0.5785337174439178,701.483615178642},{0.5785337174439178,681.483615178642},{0.5785337174439178,661.483615178642},{0.5785337174439178,641.483615178642},{0.5785337174439178,621.483615178642},{0.5785337174439178,601.483615178642},{0.5785337174439178,581.483615178642},{20.578533717443918,581.483615178642}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[3],cooInd_f20214bc.port_b1)
    annotation (Line(points={{-27.1419312527445,768.2999665690029},{-7.141931252744499,768.2999665690029},{-7.141931252744499,748.2999665690029},{-7.141931252744499,728.2999665690029},{-7.141931252744499,708.2999665690029},{-7.141931252744499,688.2999665690029},{-7.141931252744499,668.2999665690029},{-7.141931252744499,648.2999665690029},{-7.141931252744499,628.2999665690029},{-7.141931252744499,608.2999665690029},{-7.141931252744499,588.2999665690029},{12.858068747255501,588.2999665690029}},color={0,0,127}));

  //
  // End Connect Statements for 92e8bd11
  //



  //
  // Begin Connect Statements for 0969bc2c
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_70d22094.ports_bHeaWat[1], heaInd_d03a546f.port_a2)
    annotation (Line(points={{32.58817310324369,611.0550693525183},{12.58817310324369,611.0550693525183}},color={0,0,127}));
  connect(heaInd_d03a546f.port_b2,TimeSerLoa_70d22094.ports_aHeaWat[1])
    annotation (Line(points={{46.208683842772814,618.4960121681693},{66.20868384277281,618.4960121681693}},color={0,0,127}));
  connect(pressure_source_0969bc2c.ports[1], heaInd_d03a546f.port_b2)
    annotation (Line(points={{-57.35536593694214,-363.4179859622352},{-37.35536593694214,-363.4179859622352},{-37.35536593694214,-343.4179859622352},{-37.35536593694214,-323.4179859622352},{-37.35536593694214,-303.4179859622352},{-37.35536593694214,-283.4179859622352},{-37.35536593694214,-263.4179859622352},{-37.35536593694214,-243.4179859622352},{-37.35536593694214,-223.4179859622352},{-37.35536593694214,-203.4179859622351},{-37.35536593694214,-183.4179859622351},{-37.35536593694214,-163.4179859622351},{-37.35536593694214,-143.4179859622351},{-37.35536593694214,-123.4179859622351},{-37.35536593694214,-103.4179859622351},{-37.35536593694214,-83.4179859622351},{-37.35536593694214,-63.41798596223509},{-37.35536593694214,-43.41798596223509},{-37.35536593694214,-23.417985962235093},{-37.35536593694214,-3.417985962235093},{-37.35536593694214,16.582014037764907},{-37.35536593694214,36.58201403776491},{-37.35536593694214,56.58201403776491},{-37.35536593694214,76.5820140377649},{-37.35536593694214,96.5820140377649},{-37.35536593694214,116.5820140377649},{-37.35536593694214,136.5820140377649},{-37.35536593694214,156.5820140377649},{-37.35536593694214,176.5820140377649},{-37.35536593694214,196.5820140377649},{-37.35536593694214,216.5820140377649},{-37.35536593694214,236.5820140377649},{-37.35536593694214,256.5820140377649},{-37.35536593694214,276.5820140377649},{-37.35536593694214,296.5820140377649},{-37.35536593694214,316.5820140377649},{-37.35536593694214,336.5820140377649},{-37.35536593694214,356.5820140377649},{-37.35536593694214,376.5820140377649},{-37.35536593694214,396.5820140377649},{-37.35536593694214,416.5820140377649},{-37.35536593694214,436.5820140377649},{-37.35536593694214,456.5820140377649},{-37.35536593694214,476.5820140377649},{-37.35536593694214,496.5820140377649},{-37.35536593694214,516.5820140377649},{-37.35536593694214,536.5820140377649},{-37.35536593694214,556.5820140377649},{-37.35536593694214,576.5820140377649},{-37.35536593694214,596.5820140377649},{-37.35536593694214,616.5820140377649},{-17.35536593694215,616.5820140377649},{2.6446340630578504,616.5820140377649},{22.64463406305785,616.5820140377649}},color={0,0,127}));
  connect(THeaWatSet_0969bc2c.y,heaInd_d03a546f.TSetBuiSup)
    annotation (Line(points={{-18.59071842945832,-356.53593143139074},{1.4092815705416797,-356.53593143139074},{1.4092815705416797,-336.53593143139074},{1.4092815705416797,-316.53593143139074},{1.4092815705416797,-296.53593143139074},{1.4092815705416797,-276.53593143139074},{1.4092815705416797,-256.53593143139074},{1.4092815705416797,-236.53593143139074},{1.4092815705416797,-216.53593143139074},{1.4092815705416797,-196.53593143139062},{1.4092815705416797,-176.53593143139062},{1.4092815705416797,-156.53593143139062},{1.4092815705416797,-136.53593143139062},{1.4092815705416797,-116.53593143139062},{1.4092815705416797,-96.53593143139062},{1.4092815705416797,-76.53593143139062},{1.4092815705416797,-56.53593143139062},{1.4092815705416797,-36.53593143139062},{1.4092815705416797,-16.535931431390622},{1.4092815705416797,3.4640685686093775},{1.4092815705416797,23.464068568609378},{1.4092815705416797,43.46406856860938},{1.4092815705416797,63.46406856860938},{1.4092815705416797,83.46406856860938},{1.4092815705416797,103.46406856860938},{1.4092815705416797,123.46406856860938},{1.4092815705416797,143.46406856860938},{1.4092815705416797,163.46406856860938},{1.4092815705416797,183.46406856860938},{1.4092815705416797,203.46406856860938},{1.4092815705416797,223.46406856860938},{1.4092815705416797,243.46406856860938},{1.4092815705416797,263.4640685686094},{1.4092815705416797,283.4640685686094},{1.4092815705416797,303.4640685686093},{1.4092815705416797,323.4640685686093},{1.4092815705416797,343.4640685686093},{1.4092815705416797,363.4640685686093},{1.4092815705416797,383.4640685686093},{1.4092815705416797,403.4640685686093},{1.4092815705416797,423.4640685686093},{1.4092815705416797,443.4640685686093},{1.4092815705416797,463.4640685686093},{1.4092815705416797,483.4640685686093},{1.4092815705416797,503.4640685686093},{1.4092815705416797,523.4640685686093},{1.4092815705416797,543.4640685686093},{1.4092815705416797,563.4640685686093},{1.4092815705416797,583.4640685686093},{1.4092815705416797,603.4640685686093},{1.4092815705416797,623.4640685686093},{21.40928157054168,623.4640685686093}},color={0,0,127}));

  //
  // End Connect Statements for 0969bc2c
  //



  //
  // Begin Connect Statements for ae41518a
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[3],heaInd_d03a546f.port_a1)
    annotation (Line(points={{-17.637666746056397,715.7645578915997},{-17.637666746056397,695.7645578915997},{-17.637666746056397,675.7645578915997},{-17.637666746056397,655.7645578915997},{-17.637666746056397,635.7645578915997},{-17.637666746056397,615.7645578915997},{2.3623332539436035,615.7645578915997},{22.362333253943603,615.7645578915997}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[3],heaInd_d03a546f.port_b1)
    annotation (Line(points={{-20.563728646918747,713.5794852340168},{-20.563728646918747,693.5794852340168},{-20.563728646918747,673.5794852340168},{-20.563728646918747,653.5794852340168},{-20.563728646918747,633.5794852340168},{-20.563728646918747,613.5794852340168},{-0.5637286469187472,613.5794852340168},{19.436271353081253,613.5794852340168}},color={0,0,127}));

  //
  // End Connect Statements for ae41518a
  //



  //
  // Begin Connect Statements for 0a065413
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_faccf18c.ports_bChiWat[1], cooInd_457ffb93.port_a2)
    annotation (Line(points={{55.075228752298415,527.3640766213325},{55.075228752298415,507.3640766213326},{35.075228752298415,507.3640766213326},{15.075228752298415,507.3640766213326}},color={0,0,127}));
  connect(cooInd_457ffb93.port_b2,TimeSerLoa_faccf18c.ports_aChiWat[1])
    annotation (Line(points={{25.233496148346035,514.4053683624121},{45.233496148346035,514.4053683624121},{45.233496148346035,534.4053683624121},{65.23349614834603,534.4053683624121}},color={0,0,127}));
  connect(pressure_source_0a065413.ports[1], cooInd_457ffb93.port_b2)
    annotation (Line(points={{12.090248124792069,-355.67454071754537},{-7.909751875207931,-355.67454071754537},{-7.909751875207931,-335.67454071754537},{-7.909751875207931,-315.67454071754537},{-7.909751875207931,-295.67454071754537},{-7.909751875207931,-275.67454071754537},{-7.909751875207931,-255.67454071754537},{-7.909751875207931,-235.67454071754537},{-7.909751875207931,-215.67454071754537},{-7.909751875207931,-195.67454071754548},{-7.909751875207931,-175.67454071754548},{-7.909751875207931,-155.67454071754548},{-7.909751875207931,-135.67454071754548},{-7.909751875207931,-115.67454071754548},{-7.909751875207931,-95.67454071754548},{-7.909751875207931,-75.67454071754548},{-7.909751875207931,-55.67454071754548},{-7.909751875207931,-35.67454071754548},{-7.909751875207931,-15.674540717545483},{-7.909751875207931,4.325459282454517},{-7.909751875207931,24.325459282454517},{-7.909751875207931,44.32545928245452},{-7.909751875207931,64.32545928245452},{-7.909751875207931,84.32545928245452},{-7.909751875207931,104.32545928245452},{-7.909751875207931,124.32545928245452},{-7.909751875207931,144.32545928245452},{-7.909751875207931,164.32545928245452},{-7.909751875207931,184.32545928245452},{-7.909751875207931,204.32545928245452},{-7.909751875207931,224.32545928245452},{-7.909751875207931,244.32545928245452},{-7.909751875207931,264.3254592824545},{-7.909751875207931,284.3254592824545},{-7.909751875207931,304.3254592824545},{-7.909751875207931,324.3254592824545},{-7.909751875207931,344.3254592824545},{-7.909751875207931,364.3254592824545},{-7.909751875207931,384.3254592824545},{-7.909751875207931,404.3254592824545},{-7.909751875207931,424.3254592824545},{-7.909751875207931,444.3254592824545},{-7.909751875207931,464.3254592824545},{-7.909751875207931,484.3254592824545},{-7.909751875207931,504.3254592824545},{12.090248124792069,504.3254592824545}},color={0,0,127}));
  connect(TChiWatSet_0a065413.y,cooInd_457ffb93.TSetBuiSup)
    annotation (Line(points={{59.30669312058669,-360.03478542261587},{39.30669312058669,-360.03478542261587},{39.30669312058669,-340.03478542261587},{39.30669312058669,-320.03478542261587},{39.30669312058669,-300.03478542261587},{39.30669312058669,-280.03478542261587},{39.30669312058669,-260.03478542261587},{39.30669312058669,-240.03478542261587},{39.30669312058669,-220.03478542261587},{39.30669312058669,-200.03478542261587},{39.30669312058669,-180.03478542261587},{39.30669312058669,-160.03478542261587},{39.30669312058669,-140.03478542261587},{39.30669312058669,-120.03478542261587},{39.30669312058669,-100.03478542261587},{39.30669312058669,-80.03478542261587},{39.30669312058669,-60.03478542261587},{39.30669312058669,-40.03478542261587},{39.30669312058669,-20.03478542261587},{39.30669312058669,-0.03478542261586881},{39.30669312058669,19.96521457738413},{39.30669312058669,39.96521457738413},{39.30669312058669,59.96521457738413},{39.30669312058669,79.96521457738413},{39.30669312058669,99.96521457738413},{39.30669312058669,119.96521457738413},{39.30669312058669,139.96521457738413},{39.30669312058669,159.96521457738413},{39.30669312058669,179.96521457738413},{39.30669312058669,199.96521457738413},{39.30669312058669,219.96521457738413},{39.30669312058669,239.96521457738413},{39.30669312058669,259.96521457738413},{39.30669312058669,279.96521457738413},{39.30669312058669,299.9652145773841},{39.30669312058669,319.9652145773841},{39.30669312058669,339.9652145773841},{39.30669312058669,359.9652145773841},{39.30669312058669,379.9652145773841},{39.30669312058669,399.9652145773841},{39.30669312058669,419.9652145773841},{39.30669312058669,439.9652145773841},{39.30669312058669,459.9652145773841},{39.30669312058669,479.9652145773841},{39.30669312058669,499.9652145773841},{39.30669312058669,519.9652145773841},{39.30669312058669,539.9652145773841},{59.30669312058669,539.9652145773841}},color={0,0,127}));

  //
  // End Connect Statements for 0a065413
  //



  //
  // Begin Connect Statements for 915208f2
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[4],cooInd_457ffb93.port_a1)
    annotation (Line(points={{-16.50231524532144,765.7389015231993},{3.497684754678559,765.7389015231993},{3.497684754678559,745.7389015231993},{3.497684754678559,725.7389015231993},{3.497684754678559,705.7389015231993},{3.497684754678559,685.7389015231993},{3.497684754678559,665.7389015231993},{3.497684754678559,645.7389015231993},{3.497684754678559,625.7389015231993},{3.497684754678559,605.7389015231993},{3.497684754678559,585.7389015231993},{3.497684754678559,565.7389015231993},{3.497684754678559,545.7389015231993},{3.497684754678559,525.7389015231993},{3.497684754678559,505.73890152319933},{23.49768475467856,505.73890152319933}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[4],cooInd_457ffb93.port_b1)
    annotation (Line(points={{-25.52527191550604,755.2461777737578},{-5.525271915506039,755.2461777737578},{-5.525271915506039,735.2461777737578},{-5.525271915506039,715.2461777737578},{-5.525271915506039,695.2461777737578},{-5.525271915506039,675.2461777737578},{-5.525271915506039,655.2461777737578},{-5.525271915506039,635.2461777737578},{-5.525271915506039,615.2461777737578},{-5.525271915506039,595.2461777737578},{-5.525271915506039,575.2461777737578},{-5.525271915506039,555.2461777737578},{-5.525271915506039,535.2461777737578},{-5.525271915506039,515.2461777737578},{-5.525271915506039,495.2461777737579},{14.474728084493961,495.2461777737579}},color={0,0,127}));

  //
  // End Connect Statements for 915208f2
  //



  //
  // Begin Connect Statements for c9454ec2
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_faccf18c.ports_bHeaWat[1], heaInd_519466b8.port_a2)
    annotation (Line(points={{37.31626781195396,540.0760232564293},{17.316267811953963,540.0760232564293}},color={0,0,127}));
  connect(heaInd_519466b8.port_b2,TimeSerLoa_faccf18c.ports_aHeaWat[1])
    annotation (Line(points={{49.93829339187954,532.6596063840516},{69.93829339187954,532.6596063840516}},color={0,0,127}));
  connect(pressure_source_c9454ec2.ports[1], heaInd_519466b8.port_b2)
    annotation (Line(points={{-61.34382618295515,-400.24618127365284},{-41.34382618295515,-400.24618127365284},{-41.34382618295515,-380.24618127365284},{-41.34382618295515,-360.24618127365284},{-41.34382618295515,-340.24618127365284},{-41.34382618295515,-320.24618127365284},{-41.34382618295515,-300.24618127365284},{-41.34382618295515,-280.24618127365284},{-41.34382618295515,-260.24618127365284},{-41.34382618295515,-240.24618127365284},{-41.34382618295515,-220.24618127365284},{-41.34382618295515,-200.24618127365284},{-41.34382618295515,-180.24618127365284},{-41.34382618295515,-160.24618127365284},{-41.34382618295515,-140.24618127365284},{-41.34382618295515,-120.24618127365284},{-41.34382618295515,-100.24618127365284},{-41.34382618295515,-80.24618127365284},{-41.34382618295515,-60.24618127365284},{-41.34382618295515,-40.24618127365284},{-41.34382618295515,-20.246181273652837},{-41.34382618295515,-0.24618127365283726},{-41.34382618295515,19.753818726347163},{-41.34382618295515,39.75381872634716},{-41.34382618295515,59.75381872634716},{-41.34382618295515,79.75381872634716},{-41.34382618295515,99.75381872634716},{-41.34382618295515,119.75381872634716},{-41.34382618295515,139.75381872634716},{-41.34382618295515,159.75381872634716},{-41.34382618295515,179.75381872634716},{-41.34382618295515,199.75381872634716},{-41.34382618295515,219.75381872634716},{-41.34382618295515,239.75381872634716},{-41.34382618295515,259.75381872634716},{-41.34382618295515,279.75381872634716},{-41.34382618295515,299.7538187263471},{-41.34382618295515,319.7538187263471},{-41.34382618295515,339.7538187263471},{-41.34382618295515,359.7538187263471},{-41.34382618295515,379.7538187263471},{-41.34382618295515,399.7538187263471},{-41.34382618295515,419.7538187263471},{-41.34382618295515,439.7538187263471},{-41.34382618295515,459.7538187263471},{-41.34382618295515,479.7538187263471},{-41.34382618295515,499.7538187263471},{-41.34382618295515,519.7538187263472},{-41.34382618295515,539.7538187263472},{-21.343826182955155,539.7538187263472},{-1.343826182955155,539.7538187263472},{18.656173817044845,539.7538187263472}},color={0,0,127}));
  connect(THeaWatSet_c9454ec2.y,heaInd_519466b8.TSetBuiSup)
    annotation (Line(points={{-21.56173365010565,-399.33633014711245},{-1.5617336501056513,-399.33633014711245},{-1.5617336501056513,-379.33633014711245},{-1.5617336501056513,-359.33633014711245},{-1.5617336501056513,-339.33633014711245},{-1.5617336501056513,-319.33633014711245},{-1.5617336501056513,-299.33633014711245},{-1.5617336501056513,-279.33633014711245},{-1.5617336501056513,-259.33633014711245},{-1.5617336501056513,-239.33633014711245},{-1.5617336501056513,-219.33633014711245},{-1.5617336501056513,-199.33633014711245},{-1.5617336501056513,-179.33633014711245},{-1.5617336501056513,-159.33633014711245},{-1.5617336501056513,-139.33633014711245},{-1.5617336501056513,-119.33633014711245},{-1.5617336501056513,-99.33633014711245},{-1.5617336501056513,-79.33633014711245},{-1.5617336501056513,-59.33633014711245},{-1.5617336501056513,-39.33633014711245},{-1.5617336501056513,-19.33633014711245},{-1.5617336501056513,0.6636698528875513},{-1.5617336501056513,20.66366985288755},{-1.5617336501056513,40.66366985288755},{-1.5617336501056513,60.66366985288755},{-1.5617336501056513,80.66366985288755},{-1.5617336501056513,100.66366985288755},{-1.5617336501056513,120.66366985288755},{-1.5617336501056513,140.66366985288755},{-1.5617336501056513,160.66366985288755},{-1.5617336501056513,180.66366985288755},{-1.5617336501056513,200.66366985288755},{-1.5617336501056513,220.66366985288755},{-1.5617336501056513,240.66366985288755},{-1.5617336501056513,260.66366985288755},{-1.5617336501056513,280.66366985288755},{-1.5617336501056513,300.66366985288755},{-1.5617336501056513,320.66366985288755},{-1.5617336501056513,340.66366985288755},{-1.5617336501056513,360.66366985288755},{-1.5617336501056513,380.66366985288755},{-1.5617336501056513,400.66366985288755},{-1.5617336501056513,420.66366985288755},{-1.5617336501056513,440.66366985288755},{-1.5617336501056513,460.66366985288755},{-1.5617336501056513,480.66366985288755},{-1.5617336501056513,500.66366985288755},{-1.5617336501056513,520.6636698528876},{-1.5617336501056513,540.6636698528876},{18.43826634989435,540.6636698528876}},color={0,0,127}));

  //
  // End Connect Statements for c9454ec2
  //



  //
  // Begin Connect Statements for a6268b54
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[4],heaInd_519466b8.port_a1)
    annotation (Line(points={{-23.736596654743437,723.7395513178416},{-23.736596654743437,703.7395513178416},{-23.736596654743437,683.7395513178416},{-23.736596654743437,663.7395513178416},{-23.736596654743437,643.7395513178416},{-23.736596654743437,623.7395513178416},{-23.736596654743437,603.7395513178416},{-23.736596654743437,583.7395513178416},{-23.736596654743437,563.7395513178416},{-23.736596654743437,543.7395513178415},{-3.736596654743437,543.7395513178415},{16.263403345256563,543.7395513178415}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[4],heaInd_519466b8.port_b1)
    annotation (Line(points={{-21.81446170982821,728.6707090820807},{-21.81446170982821,708.6707090820807},{-21.81446170982821,688.6707090820807},{-21.81446170982821,668.6707090820807},{-21.81446170982821,648.6707090820807},{-21.81446170982821,628.6707090820807},{-21.81446170982821,608.6707090820807},{-21.81446170982821,588.6707090820807},{-21.81446170982821,568.6707090820807},{-21.81446170982821,548.6707090820807},{-1.8144617098282083,548.6707090820807},{18.18553829017179,548.6707090820807}},color={0,0,127}));

  //
  // End Connect Statements for a6268b54
  //



  //
  // Begin Connect Statements for bb2c650d
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_d1d54389.ports_bChiWat[1], cooInd_5627dad0.port_a2)
    annotation (Line(points={{34.55459801471714,458.5685851771505},{14.554598014717143,458.5685851771505}},color={0,0,127}));
  connect(cooInd_5627dad0.port_b2,TimeSerLoa_d1d54389.ports_aChiWat[1])
    annotation (Line(points={{36.4029425615026,456.80865220572656},{56.402942561502584,456.80865220572656}},color={0,0,127}));
  connect(pressure_source_bb2c650d.ports[1], cooInd_5627dad0.port_b2)
    annotation (Line(points={{25.0947178220991,-393.9708306118864},{5.094717822099099,-393.9708306118864},{5.094717822099099,-373.9708306118864},{5.094717822099099,-353.9708306118864},{5.094717822099099,-333.9708306118864},{5.094717822099099,-313.9708306118864},{5.094717822099099,-293.9708306118864},{5.094717822099099,-273.9708306118864},{5.094717822099099,-253.9708306118864},{5.094717822099099,-233.9708306118864},{5.094717822099099,-213.9708306118863},{5.094717822099099,-193.9708306118863},{5.094717822099099,-173.9708306118863},{5.094717822099099,-153.9708306118863},{5.094717822099099,-133.9708306118863},{5.094717822099099,-113.9708306118863},{5.094717822099099,-93.9708306118863},{5.094717822099099,-73.9708306118863},{5.094717822099099,-53.9708306118863},{5.094717822099099,-33.9708306118863},{5.094717822099099,-13.9708306118863},{5.094717822099099,6.029169388113701},{5.094717822099099,26.0291693881137},{5.094717822099099,46.0291693881137},{5.094717822099099,66.0291693881137},{5.094717822099099,86.0291693881137},{5.094717822099099,106.0291693881137},{5.094717822099099,126.0291693881137},{5.094717822099099,146.0291693881137},{5.094717822099099,166.0291693881137},{5.094717822099099,186.0291693881137},{5.094717822099099,206.0291693881137},{5.094717822099099,226.0291693881137},{5.094717822099099,246.0291693881137},{5.094717822099099,266.0291693881137},{5.094717822099099,286.0291693881137},{5.094717822099099,306.0291693881137},{5.094717822099099,326.0291693881137},{5.094717822099099,346.0291693881137},{5.094717822099099,366.0291693881137},{5.094717822099099,386.0291693881137},{5.094717822099099,406.0291693881137},{5.094717822099099,426.0291693881137},{5.094717822099099,446.0291693881137},{5.094717822099099,466.0291693881137},{25.0947178220991,466.0291693881137}},color={0,0,127}));
  connect(TChiWatSet_bb2c650d.y,cooInd_5627dad0.TSetBuiSup)
    annotation (Line(points={{55.79970797602846,-395.61429202533145},{35.79970797602846,-395.61429202533145},{35.79970797602846,-375.61429202533145},{35.79970797602846,-355.61429202533145},{35.79970797602846,-335.61429202533145},{35.79970797602846,-315.61429202533145},{35.79970797602846,-295.61429202533145},{35.79970797602846,-275.61429202533145},{35.79970797602846,-255.61429202533145},{35.79970797602846,-235.61429202533145},{35.79970797602846,-215.61429202533145},{35.79970797602846,-195.61429202533145},{35.79970797602846,-175.61429202533145},{35.79970797602846,-155.61429202533145},{35.79970797602846,-135.61429202533145},{35.79970797602846,-115.61429202533145},{35.79970797602846,-95.61429202533145},{35.79970797602846,-75.61429202533145},{35.79970797602846,-55.61429202533145},{35.79970797602846,-35.61429202533145},{35.79970797602846,-15.614292025331451},{35.79970797602846,4.385707974668549},{35.79970797602846,24.38570797466855},{35.79970797602846,44.38570797466855},{35.79970797602846,64.38570797466855},{35.79970797602846,84.38570797466855},{35.79970797602846,104.38570797466855},{35.79970797602846,124.38570797466855},{35.79970797602846,144.38570797466855},{35.79970797602846,164.38570797466855},{35.79970797602846,184.38570797466855},{35.79970797602846,204.38570797466855},{35.79970797602846,224.38570797466855},{35.79970797602846,244.38570797466855},{35.79970797602846,264.38570797466855},{35.79970797602846,284.38570797466855},{35.79970797602846,304.3857079746686},{35.79970797602846,324.3857079746686},{35.79970797602846,344.3857079746686},{35.79970797602846,364.3857079746686},{35.79970797602846,384.3857079746686},{35.79970797602846,404.3857079746686},{35.79970797602846,424.3857079746686},{35.79970797602846,444.3857079746686},{35.79970797602846,464.3857079746686},{55.79970797602846,464.3857079746686}},color={0,0,127}));

  //
  // End Connect Statements for bb2c650d
  //



  //
  // Begin Connect Statements for a6b3c8ee
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[5],cooInd_5627dad0.port_a1)
    annotation (Line(points={{-20.422688364941692,761.5001063577337},{-0.42268836494169193,761.5001063577337},{-0.42268836494169193,741.5001063577337},{-0.42268836494169193,721.5001063577337},{-0.42268836494169193,701.5001063577337},{-0.42268836494169193,681.5001063577337},{-0.42268836494169193,661.5001063577337},{-0.42268836494169193,641.5001063577337},{-0.42268836494169193,621.5001063577337},{-0.42268836494169193,601.5001063577337},{-0.42268836494169193,581.5001063577337},{-0.42268836494169193,561.5001063577337},{-0.42268836494169193,541.5001063577336},{-0.42268836494169193,521.5001063577336},{-0.42268836494169193,501.5001063577336},{-0.42268836494169193,481.5001063577336},{-0.42268836494169193,461.5001063577336},{19.577311635058308,461.5001063577336}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[5],cooInd_5627dad0.port_b1)
    annotation (Line(points={{-18.63395721293989,767.8602354946242},{1.3660427870601097,767.8602354946242},{1.3660427870601097,747.8602354946242},{1.3660427870601097,727.8602354946242},{1.3660427870601097,707.8602354946242},{1.3660427870601097,687.8602354946242},{1.3660427870601097,667.8602354946242},{1.3660427870601097,647.8602354946242},{1.3660427870601097,627.8602354946242},{1.3660427870601097,607.8602354946242},{1.3660427870601097,587.8602354946242},{1.3660427870601097,567.8602354946242},{1.3660427870601097,547.8602354946242},{1.3660427870601097,527.8602354946242},{1.3660427870601097,507.8602354946242},{1.3660427870601097,487.8602354946242},{1.3660427870601097,467.8602354946242},{21.36604278706011,467.8602354946242}},color={0,0,127}));

  //
  // End Connect Statements for a6b3c8ee
  //



  //
  // Begin Connect Statements for e2d5599d
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_d1d54389.ports_bHeaWat[1], heaInd_8414d585.port_a2)
    annotation (Line(points={{53.811418032529815,445.9365572036681},{53.811418032529815,425.9365572036681},{33.811418032529815,425.9365572036681},{13.811418032529815,425.9365572036681}},color={0,0,127}));
  connect(heaInd_8414d585.port_b2,TimeSerLoa_d1d54389.ports_aHeaWat[1])
    annotation (Line(points={{13.929121745814882,433.37609866448156},{33.92912174581488,433.37609866448156},{33.92912174581488,453.37609866448156},{53.92912174581488,453.37609866448156}},color={0,0,127}));
  connect(pressure_source_e2d5599d.ports[1], heaInd_8414d585.port_b2)
    annotation (Line(points={{-51.49009079546478,-439.3849934824648},{-31.49009079546478,-439.3849934824648},{-31.49009079546478,-419.3849934824648},{-31.49009079546478,-399.3849934824648},{-31.49009079546478,-379.3849934824648},{-31.49009079546478,-359.3849934824648},{-31.49009079546478,-339.3849934824648},{-31.49009079546478,-319.3849934824648},{-31.49009079546478,-299.3849934824648},{-31.49009079546478,-279.3849934824648},{-31.49009079546478,-259.3849934824648},{-31.49009079546478,-239.38499348246478},{-31.49009079546478,-219.38499348246478},{-31.49009079546478,-199.38499348246478},{-31.49009079546478,-179.38499348246478},{-31.49009079546478,-159.38499348246478},{-31.49009079546478,-139.38499348246478},{-31.49009079546478,-119.38499348246478},{-31.49009079546478,-99.38499348246478},{-31.49009079546478,-79.38499348246478},{-31.49009079546478,-59.38499348246478},{-31.49009079546478,-39.38499348246478},{-31.49009079546478,-19.38499348246478},{-31.49009079546478,0.6150065175352211},{-31.49009079546478,20.61500651753522},{-31.49009079546478,40.61500651753522},{-31.49009079546478,60.61500651753522},{-31.49009079546478,80.61500651753522},{-31.49009079546478,100.61500651753522},{-31.49009079546478,120.61500651753522},{-31.49009079546478,140.61500651753522},{-31.49009079546478,160.61500651753522},{-31.49009079546478,180.61500651753522},{-31.49009079546478,200.61500651753522},{-31.49009079546478,220.61500651753522},{-31.49009079546478,240.61500651753522},{-31.49009079546478,260.6150065175352},{-31.49009079546478,280.6150065175352},{-31.49009079546478,300.6150065175352},{-31.49009079546478,320.6150065175352},{-31.49009079546478,340.6150065175352},{-31.49009079546478,360.6150065175352},{-31.49009079546478,380.6150065175352},{-31.49009079546478,400.6150065175352},{-31.49009079546478,420.6150065175352},{-11.49009079546478,420.6150065175352},{8.50990920453522,420.6150065175352},{28.50990920453522,420.6150065175352}},color={0,0,127}));
  connect(THeaWatSet_e2d5599d.y,heaInd_8414d585.TSetBuiSup)
    annotation (Line(points={{-11.957803785549856,-430.54392031395287},{8.042196214450144,-430.54392031395287},{8.042196214450144,-410.54392031395287},{8.042196214450144,-390.54392031395287},{8.042196214450144,-370.54392031395287},{8.042196214450144,-350.54392031395287},{8.042196214450144,-330.54392031395287},{8.042196214450144,-310.54392031395287},{8.042196214450144,-290.54392031395287},{8.042196214450144,-270.54392031395287},{8.042196214450144,-250.54392031395287},{8.042196214450144,-230.54392031395287},{8.042196214450144,-210.54392031395298},{8.042196214450144,-190.54392031395298},{8.042196214450144,-170.54392031395298},{8.042196214450144,-150.54392031395298},{8.042196214450144,-130.54392031395298},{8.042196214450144,-110.54392031395298},{8.042196214450144,-90.54392031395298},{8.042196214450144,-70.54392031395298},{8.042196214450144,-50.54392031395298},{8.042196214450144,-30.54392031395298},{8.042196214450144,-10.543920313952981},{8.042196214450144,9.456079686047019},{8.042196214450144,29.45607968604702},{8.042196214450144,49.45607968604702},{8.042196214450144,69.45607968604702},{8.042196214450144,89.45607968604702},{8.042196214450144,109.45607968604702},{8.042196214450144,129.45607968604702},{8.042196214450144,149.45607968604702},{8.042196214450144,169.45607968604702},{8.042196214450144,189.45607968604702},{8.042196214450144,209.45607968604702},{8.042196214450144,229.45607968604702},{8.042196214450144,249.45607968604702},{8.042196214450144,269.456079686047},{8.042196214450144,289.456079686047},{8.042196214450144,309.4560796860471},{8.042196214450144,329.4560796860471},{8.042196214450144,349.4560796860471},{8.042196214450144,369.4560796860471},{8.042196214450144,389.4560796860471},{8.042196214450144,409.4560796860471},{8.042196214450144,429.4560796860471},{28.042196214450144,429.4560796860471}},color={0,0,127}));

  //
  // End Connect Statements for e2d5599d
  //



  //
  // Begin Connect Statements for 9aca04d3
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[5],heaInd_8414d585.port_a1)
    annotation (Line(points={{-29.896218162492275,710.0186097970061},{-29.896218162492275,690.0186097970061},{-29.896218162492275,670.0186097970061},{-29.896218162492275,650.0186097970061},{-29.896218162492275,630.0186097970061},{-29.896218162492275,610.0186097970061},{-29.896218162492275,590.0186097970061},{-29.896218162492275,570.0186097970061},{-29.896218162492275,550.0186097970061},{-29.896218162492275,530.0186097970061},{-29.896218162492275,510.0186097970061},{-29.896218162492275,490.0186097970061},{-29.896218162492275,470.0186097970061},{-29.896218162492275,450.0186097970061},{-29.896218162492275,430.0186097970061},{-29.896218162492275,410.0186097970061},{-9.896218162492275,410.0186097970061},{10.103781837507725,410.0186097970061}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[5],heaInd_8414d585.port_b1)
    annotation (Line(points={{-14.315593087871918,720.5597941448902},{-14.315593087871918,700.5597941448902},{-14.315593087871918,680.5597941448902},{-14.315593087871918,660.5597941448902},{-14.315593087871918,640.5597941448902},{-14.315593087871918,620.5597941448902},{-14.315593087871918,600.5597941448902},{-14.315593087871918,580.5597941448902},{-14.315593087871918,560.5597941448902},{-14.315593087871918,540.5597941448902},{-14.315593087871918,520.5597941448902},{-14.315593087871918,500.5597941448902},{-14.315593087871918,480.5597941448902},{-14.315593087871918,460.5597941448902},{-14.315593087871918,440.5597941448902},{-14.315593087871918,420.5597941448902},{5.6844069121280825,420.5597941448902},{25.684406912128082,420.5597941448902}},color={0,0,127}));

  //
  // End Connect Statements for 9aca04d3
  //



  //
  // Begin Connect Statements for 26defd93
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_421efb76.ports_bChiWat[1], cooInd_fd7873c6.port_a2)
    annotation (Line(points={{47.79719632568782,371.23940095871416},{27.797196325687835,371.23940095871416}},color={0,0,127}));
  connect(cooInd_fd7873c6.port_b2,TimeSerLoa_421efb76.ports_aChiWat[1])
    annotation (Line(points={{41.063775620209526,381.5049556405503},{61.063775620209526,381.5049556405503}},color={0,0,127}));
  connect(pressure_source_26defd93.ports[1], cooInd_fd7873c6.port_b2)
    annotation (Line(points={{26.054822495997698,-430.6797101890054},{6.054822495997698,-430.6797101890054},{6.054822495997698,-410.6797101890054},{6.054822495997698,-390.6797101890054},{6.054822495997698,-370.6797101890054},{6.054822495997698,-350.6797101890054},{6.054822495997698,-330.6797101890054},{6.054822495997698,-310.6797101890054},{6.054822495997698,-290.6797101890054},{6.054822495997698,-270.6797101890054},{6.054822495997698,-250.6797101890054},{6.054822495997698,-230.6797101890054},{6.054822495997698,-210.6797101890055},{6.054822495997698,-190.6797101890055},{6.054822495997698,-170.6797101890055},{6.054822495997698,-150.6797101890055},{6.054822495997698,-130.6797101890055},{6.054822495997698,-110.6797101890055},{6.054822495997698,-90.6797101890055},{6.054822495997698,-70.6797101890055},{6.054822495997698,-50.679710189005505},{6.054822495997698,-30.679710189005505},{6.054822495997698,-10.679710189005505},{6.054822495997698,9.320289810994495},{6.054822495997698,29.320289810994495},{6.054822495997698,49.320289810994495},{6.054822495997698,69.3202898109945},{6.054822495997698,89.3202898109945},{6.054822495997698,109.3202898109945},{6.054822495997698,129.3202898109945},{6.054822495997698,149.3202898109945},{6.054822495997698,169.3202898109945},{6.054822495997698,189.3202898109945},{6.054822495997698,209.3202898109945},{6.054822495997698,229.3202898109945},{6.054822495997698,249.3202898109945},{6.054822495997698,269.3202898109945},{6.054822495997698,289.3202898109945},{6.054822495997698,309.32028981099455},{6.054822495997698,329.32028981099455},{6.054822495997698,349.32028981099455},{6.054822495997698,369.32028981099455},{6.054822495997698,389.32028981099455},{26.054822495997698,389.32028981099455}},color={0,0,127}));
  connect(TChiWatSet_26defd93.y,cooInd_fd7873c6.TSetBuiSup)
    annotation (Line(points={{68.8287608305069,-446.55337274361204},{48.828760830506894,-446.55337274361204},{48.828760830506894,-426.55337274361204},{48.828760830506894,-406.55337274361204},{48.828760830506894,-386.55337274361204},{48.828760830506894,-366.55337274361204},{48.828760830506894,-346.55337274361204},{48.828760830506894,-326.55337274361204},{48.828760830506894,-306.55337274361204},{48.828760830506894,-286.55337274361204},{48.828760830506894,-266.55337274361204},{48.828760830506894,-246.55337274361204},{48.828760830506894,-226.55337274361204},{48.828760830506894,-206.55337274361216},{48.828760830506894,-186.55337274361216},{48.828760830506894,-166.55337274361216},{48.828760830506894,-146.55337274361216},{48.828760830506894,-126.55337274361216},{48.828760830506894,-106.55337274361216},{48.828760830506894,-86.55337274361216},{48.828760830506894,-66.55337274361216},{48.828760830506894,-46.55337274361216},{48.828760830506894,-26.553372743612158},{48.828760830506894,-6.553372743612158},{48.828760830506894,13.446627256387842},{48.828760830506894,33.44662725638784},{48.828760830506894,53.44662725638784},{48.828760830506894,73.44662725638784},{48.828760830506894,93.44662725638784},{48.828760830506894,113.44662725638784},{48.828760830506894,133.44662725638784},{48.828760830506894,153.44662725638784},{48.828760830506894,173.44662725638784},{48.828760830506894,193.44662725638784},{48.828760830506894,213.44662725638784},{48.828760830506894,233.44662725638784},{48.828760830506894,253.44662725638784},{48.828760830506894,273.44662725638784},{48.828760830506894,293.44662725638784},{48.828760830506894,313.44662725638784},{48.828760830506894,333.44662725638784},{48.828760830506894,353.44662725638784},{48.828760830506894,373.44662725638784},{68.8287608305069,373.44662725638784}},color={0,0,127}));

  //
  // End Connect Statements for 26defd93
  //



  //
  // Begin Connect Statements for 62d24f38
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[6],cooInd_fd7873c6.port_a1)
    annotation (Line(points={{-14.378129907212056,767.1036750043972},{5.621870092787944,767.1036750043972},{5.621870092787944,747.1036750043972},{5.621870092787944,727.1036750043972},{5.621870092787944,707.1036750043972},{5.621870092787944,687.1036750043972},{5.621870092787944,667.1036750043972},{5.621870092787944,647.1036750043972},{5.621870092787944,627.1036750043972},{5.621870092787944,607.1036750043972},{5.621870092787944,587.1036750043972},{5.621870092787944,567.1036750043972},{5.621870092787944,547.1036750043972},{5.621870092787944,527.1036750043972},{5.621870092787944,507.10367500439725},{5.621870092787944,487.10367500439725},{5.621870092787944,467.10367500439725},{5.621870092787944,447.10367500439725},{5.621870092787944,427.10367500439725},{5.621870092787944,407.10367500439725},{5.621870092787944,387.10367500439725},{25.621870092787944,387.10367500439725}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[6],cooInd_fd7873c6.port_b1)
    annotation (Line(points={{-22.464949501511413,769.546551520174},{-2.4649495015114127,769.546551520174},{-2.4649495015114127,749.546551520174},{-2.4649495015114127,729.546551520174},{-2.4649495015114127,709.546551520174},{-2.4649495015114127,689.546551520174},{-2.4649495015114127,669.546551520174},{-2.4649495015114127,649.546551520174},{-2.4649495015114127,629.546551520174},{-2.4649495015114127,609.546551520174},{-2.4649495015114127,589.546551520174},{-2.4649495015114127,569.546551520174},{-2.4649495015114127,549.546551520174},{-2.4649495015114127,529.546551520174},{-2.4649495015114127,509.546551520174},{-2.4649495015114127,489.546551520174},{-2.4649495015114127,469.546551520174},{-2.4649495015114127,449.546551520174},{-2.4649495015114127,429.546551520174},{-2.4649495015114127,409.546551520174},{-2.4649495015114127,389.546551520174},{17.535050498488587,389.546551520174}},color={0,0,127}));

  //
  // End Connect Statements for 62d24f38
  //



  //
  // Begin Connect Statements for a170f81a
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_421efb76.ports_bHeaWat[1], heaInd_4dc395d3.port_a2)
    annotation (Line(points={{66.472317222069,365.7264082367989},{66.472317222069,345.7264082367989},{46.472317222068995,345.7264082367989},{26.47231722206901,345.7264082367989}},color={0,0,127}));
  connect(heaInd_4dc395d3.port_b2,TimeSerLoa_421efb76.ports_aHeaWat[1])
    annotation (Line(points={{28.88677661722096,358.1494548135993},{48.88677661722096,358.1494548135993},{48.88677661722096,378.1494548135993},{68.88677661722096,378.1494548135993}},color={0,0,127}));
  connect(pressure_source_a170f81a.ports[1], heaInd_4dc395d3.port_b2)
    annotation (Line(points={{-62.80954146565263,-479.0761967783262},{-42.80954146565263,-479.0761967783262},{-42.80954146565263,-459.0761967783262},{-42.80954146565263,-439.0761967783262},{-42.80954146565263,-419.0761967783262},{-42.80954146565263,-399.0761967783262},{-42.80954146565263,-379.0761967783262},{-42.80954146565263,-359.0761967783262},{-42.80954146565263,-339.0761967783262},{-42.80954146565263,-319.0761967783262},{-42.80954146565263,-299.0761967783262},{-42.80954146565263,-279.0761967783262},{-42.80954146565263,-259.0761967783262},{-42.80954146565263,-239.07619677832622},{-42.80954146565263,-219.07619677832622},{-42.80954146565263,-199.07619677832622},{-42.80954146565263,-179.07619677832622},{-42.80954146565263,-159.07619677832622},{-42.80954146565263,-139.07619677832622},{-42.80954146565263,-119.07619677832622},{-42.80954146565263,-99.07619677832622},{-42.80954146565263,-79.07619677832622},{-42.80954146565263,-59.07619677832622},{-42.80954146565263,-39.07619677832622},{-42.80954146565263,-19.07619677832622},{-42.80954146565263,0.9238032216737793},{-42.80954146565263,20.92380322167378},{-42.80954146565263,40.92380322167378},{-42.80954146565263,60.92380322167378},{-42.80954146565263,80.92380322167378},{-42.80954146565263,100.92380322167378},{-42.80954146565263,120.92380322167378},{-42.80954146565263,140.92380322167378},{-42.80954146565263,160.92380322167378},{-42.80954146565263,180.92380322167378},{-42.80954146565263,200.92380322167378},{-42.80954146565263,220.92380322167378},{-42.80954146565263,240.92380322167378},{-42.80954146565263,260.9238032216738},{-42.80954146565263,280.9238032216738},{-42.80954146565263,300.9238032216737},{-42.80954146565263,320.9238032216737},{-42.80954146565263,340.9238032216737},{-22.80954146565263,340.9238032216737},{-2.8095414656526287,340.9238032216737},{17.19045853434737,340.9238032216737}},color={0,0,127}));
  connect(THeaWatSet_a170f81a.y,heaInd_4dc395d3.TSetBuiSup)
    annotation (Line(points={{-11.139943299437249,-473.69639551343334},{8.860056700562751,-473.69639551343334},{8.860056700562751,-453.69639551343334},{8.860056700562751,-433.69639551343334},{8.860056700562751,-413.69639551343334},{8.860056700562751,-393.69639551343334},{8.860056700562751,-373.69639551343334},{8.860056700562751,-353.69639551343334},{8.860056700562751,-333.69639551343334},{8.860056700562751,-313.69639551343334},{8.860056700562751,-293.69639551343334},{8.860056700562751,-273.69639551343334},{8.860056700562751,-253.69639551343334},{8.860056700562751,-233.69639551343334},{8.860056700562751,-213.69639551343334},{8.860056700562751,-193.69639551343334},{8.860056700562751,-173.69639551343334},{8.860056700562751,-153.69639551343334},{8.860056700562751,-133.69639551343334},{8.860056700562751,-113.69639551343334},{8.860056700562751,-93.69639551343334},{8.860056700562751,-73.69639551343334},{8.860056700562751,-53.696395513433345},{8.860056700562751,-33.696395513433345},{8.860056700562751,-13.696395513433345},{8.860056700562751,6.303604486566655},{8.860056700562751,26.303604486566655},{8.860056700562751,46.303604486566655},{8.860056700562751,66.30360448656666},{8.860056700562751,86.30360448656666},{8.860056700562751,106.30360448656666},{8.860056700562751,126.30360448656666},{8.860056700562751,146.30360448656666},{8.860056700562751,166.30360448656666},{8.860056700562751,186.30360448656666},{8.860056700562751,206.30360448656666},{8.860056700562751,226.30360448656666},{8.860056700562751,246.30360448656666},{8.860056700562751,266.30360448656666},{8.860056700562751,286.30360448656666},{8.860056700562751,306.3036044865667},{8.860056700562751,326.3036044865667},{8.860056700562751,346.3036044865667},{28.86005670056275,346.3036044865667}},color={0,0,127}));

  //
  // End Connect Statements for a170f81a
  //



  //
  // Begin Connect Statements for 843aa841
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[6],heaInd_4dc395d3.port_a1)
    annotation (Line(points={{-14.054614965037985,725.4039709653849},{-14.054614965037985,705.4039709653849},{-14.054614965037985,685.4039709653849},{-14.054614965037985,665.4039709653849},{-14.054614965037985,645.4039709653849},{-14.054614965037985,625.4039709653849},{-14.054614965037985,605.4039709653849},{-14.054614965037985,585.4039709653849},{-14.054614965037985,565.4039709653849},{-14.054614965037985,545.4039709653848},{-14.054614965037985,525.4039709653848},{-14.054614965037985,505.4039709653849},{-14.054614965037985,485.4039709653849},{-14.054614965037985,465.4039709653849},{-14.054614965037985,445.4039709653849},{-14.054614965037985,425.4039709653849},{-14.054614965037985,405.4039709653849},{-14.054614965037985,385.4039709653849},{-14.054614965037985,365.4039709653849},{-14.054614965037985,345.4039709653849},{5.945385034962015,345.4039709653849},{25.945385034962015,345.4039709653849}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[6],heaInd_4dc395d3.port_b1)
    annotation (Line(points={{-18.28089622823407,715.6687322064734},{-18.28089622823407,695.6687322064734},{-18.28089622823407,675.6687322064734},{-18.28089622823407,655.6687322064734},{-18.28089622823407,635.6687322064734},{-18.28089622823407,615.6687322064734},{-18.28089622823407,595.6687322064734},{-18.28089622823407,575.6687322064734},{-18.28089622823407,555.6687322064734},{-18.28089622823407,535.6687322064734},{-18.28089622823407,515.6687322064734},{-18.28089622823407,495.66873220647335},{-18.28089622823407,475.66873220647335},{-18.28089622823407,455.66873220647335},{-18.28089622823407,435.66873220647335},{-18.28089622823407,415.66873220647335},{-18.28089622823407,395.66873220647335},{-18.28089622823407,375.66873220647335},{-18.28089622823407,355.66873220647335},{-18.28089622823407,335.66873220647335},{1.7191037717659299,335.66873220647335},{21.71910377176593,335.66873220647335}},color={0,0,127}));

  //
  // End Connect Statements for 843aa841
  //



  //
  // Begin Connect Statements for 7036ff35
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_9386ccaf.ports_bChiWat[1], cooInd_63ede8a9.port_a2)
    annotation (Line(points={{69.22366475783926,278.88285271891573},{69.22366475783926,258.88285271891573},{49.22366475783926,258.88285271891573},{29.22366475783926,258.88285271891573}},color={0,0,127}));
  connect(cooInd_63ede8a9.port_b2,TimeSerLoa_9386ccaf.ports_aChiWat[1])
    annotation (Line(points={{11.676307412587846,282.73034603379244},{31.676307412587846,282.73034603379244},{31.676307412587846,302.73034603379244},{51.676307412587846,302.73034603379244}},color={0,0,127}));
  connect(pressure_source_7036ff35.ports[1], cooInd_63ede8a9.port_b2)
    annotation (Line(points={{13.444779099530493,-475.299398402467},{-6.555220900469507,-475.299398402467},{-6.555220900469507,-455.299398402467},{-6.555220900469507,-435.299398402467},{-6.555220900469507,-415.299398402467},{-6.555220900469507,-395.299398402467},{-6.555220900469507,-375.299398402467},{-6.555220900469507,-355.299398402467},{-6.555220900469507,-335.299398402467},{-6.555220900469507,-315.299398402467},{-6.555220900469507,-295.299398402467},{-6.555220900469507,-275.299398402467},{-6.555220900469507,-255.29939840246698},{-6.555220900469507,-235.29939840246698},{-6.555220900469507,-215.29939840246698},{-6.555220900469507,-195.29939840246698},{-6.555220900469507,-175.29939840246698},{-6.555220900469507,-155.29939840246698},{-6.555220900469507,-135.29939840246698},{-6.555220900469507,-115.29939840246698},{-6.555220900469507,-95.29939840246698},{-6.555220900469507,-75.29939840246698},{-6.555220900469507,-55.29939840246698},{-6.555220900469507,-35.29939840246698},{-6.555220900469507,-15.299398402466977},{-6.555220900469507,4.700601597533023},{-6.555220900469507,24.700601597533023},{-6.555220900469507,44.70060159753302},{-6.555220900469507,64.70060159753302},{-6.555220900469507,84.70060159753302},{-6.555220900469507,104.70060159753302},{-6.555220900469507,124.70060159753302},{-6.555220900469507,144.70060159753302},{-6.555220900469507,164.70060159753302},{-6.555220900469507,184.70060159753302},{-6.555220900469507,204.70060159753302},{-6.555220900469507,224.70060159753302},{-6.555220900469507,244.70060159753302},{-6.555220900469507,264.700601597533},{13.444779099530493,264.700601597533}},color={0,0,127}));
  connect(TChiWatSet_7036ff35.y,cooInd_63ede8a9.TSetBuiSup)
    annotation (Line(points={{68.48519178569754,-488.416278805395},{48.48519178569754,-488.416278805395},{48.48519178569754,-468.416278805395},{48.48519178569754,-448.416278805395},{48.48519178569754,-428.416278805395},{48.48519178569754,-408.416278805395},{48.48519178569754,-388.416278805395},{48.48519178569754,-368.416278805395},{48.48519178569754,-348.416278805395},{48.48519178569754,-328.416278805395},{48.48519178569754,-308.416278805395},{48.48519178569754,-288.416278805395},{48.48519178569754,-268.416278805395},{48.48519178569754,-248.416278805395},{48.48519178569754,-228.416278805395},{48.48519178569754,-208.416278805395},{48.48519178569754,-188.416278805395},{48.48519178569754,-168.416278805395},{48.48519178569754,-148.416278805395},{48.48519178569754,-128.416278805395},{48.48519178569754,-108.416278805395},{48.48519178569754,-88.416278805395},{48.48519178569754,-68.416278805395},{48.48519178569754,-48.416278805394995},{48.48519178569754,-28.416278805394995},{48.48519178569754,-8.416278805394995},{48.48519178569754,11.583721194605005},{48.48519178569754,31.583721194605005},{48.48519178569754,51.583721194605005},{48.48519178569754,71.583721194605},{48.48519178569754,91.583721194605},{48.48519178569754,111.583721194605},{48.48519178569754,131.583721194605},{48.48519178569754,151.583721194605},{48.48519178569754,171.583721194605},{48.48519178569754,191.583721194605},{48.48519178569754,211.583721194605},{48.48519178569754,231.583721194605},{48.48519178569754,251.583721194605},{48.48519178569754,271.583721194605},{48.48519178569754,291.583721194605},{68.48519178569754,291.583721194605}},color={0,0,127}));

  //
  // End Connect Statements for 7036ff35
  //



  //
  // Begin Connect Statements for fc49554a
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[7],cooInd_63ede8a9.port_a1)
    annotation (Line(points={{-21.386383197902816,753.754398599043},{-1.3863831979028163,753.754398599043},{-1.3863831979028163,733.754398599043},{-1.3863831979028163,713.754398599043},{-1.3863831979028163,693.754398599043},{-1.3863831979028163,673.754398599043},{-1.3863831979028163,653.754398599043},{-1.3863831979028163,633.754398599043},{-1.3863831979028163,613.754398599043},{-1.3863831979028163,593.754398599043},{-1.3863831979028163,573.754398599043},{-1.3863831979028163,553.754398599043},{-1.3863831979028163,533.754398599043},{-1.3863831979028163,513.754398599043},{-1.3863831979028163,493.75439859904304},{-1.3863831979028163,473.75439859904304},{-1.3863831979028163,453.75439859904304},{-1.3863831979028163,433.75439859904304},{-1.3863831979028163,413.75439859904304},{-1.3863831979028163,393.75439859904304},{-1.3863831979028163,373.75439859904304},{-1.3863831979028163,353.75439859904304},{-1.3863831979028163,333.75439859904304},{-1.3863831979028163,313.75439859904304},{-1.3863831979028163,293.75439859904304},{-1.3863831979028163,273.75439859904304},{-1.3863831979028163,253.75439859904304},{18.613616802097184,253.75439859904304}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[7],cooInd_63ede8a9.port_b1)
    annotation (Line(points={{-11.27541279342364,767.5904460138722},{8.72458720657636,767.5904460138722},{8.72458720657636,747.5904460138722},{8.72458720657636,727.5904460138722},{8.72458720657636,707.5904460138722},{8.72458720657636,687.5904460138722},{8.72458720657636,667.5904460138722},{8.72458720657636,647.5904460138722},{8.72458720657636,627.5904460138722},{8.72458720657636,607.5904460138722},{8.72458720657636,587.5904460138722},{8.72458720657636,567.5904460138722},{8.72458720657636,547.5904460138722},{8.72458720657636,527.5904460138722},{8.72458720657636,507.5904460138722},{8.72458720657636,487.5904460138722},{8.72458720657636,467.5904460138722},{8.72458720657636,447.5904460138722},{8.72458720657636,427.5904460138722},{8.72458720657636,407.5904460138722},{8.72458720657636,387.5904460138722},{8.72458720657636,367.5904460138722},{8.72458720657636,347.5904460138722},{8.72458720657636,327.5904460138722},{8.72458720657636,307.5904460138722},{8.72458720657636,287.5904460138722},{8.72458720657636,267.5904460138722},{28.72458720657636,267.5904460138722}},color={0,0,127}));

  //
  // End Connect Statements for fc49554a
  //



  //
  // Begin Connect Statements for d05d6fdc
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_9386ccaf.ports_bHeaWat[1], heaInd_e5bf5b65.port_a2)
    annotation (Line(points={{41.541369653757556,295.50365111094493},{21.54136965375757,295.50365111094493}},color={0,0,127}));
  connect(heaInd_e5bf5b65.port_b2,TimeSerLoa_9386ccaf.ports_aHeaWat[1])
    annotation (Line(points={{38.60502954587821,294.01478911360573},{58.60502954587821,294.01478911360573}},color={0,0,127}));
  connect(pressure_source_d05d6fdc.ports[1], heaInd_e5bf5b65.port_b2)
    annotation (Line(points={{-57.86395058279757,-529.4486251744713},{-37.86395058279757,-529.4486251744713},{-37.86395058279757,-509.4486251744713},{-37.86395058279757,-489.4486251744713},{-37.86395058279757,-469.4486251744713},{-37.86395058279757,-449.4486251744713},{-37.86395058279757,-429.4486251744713},{-37.86395058279757,-409.4486251744713},{-37.86395058279757,-389.4486251744713},{-37.86395058279757,-369.4486251744713},{-37.86395058279757,-349.4486251744713},{-37.86395058279757,-329.4486251744713},{-37.86395058279757,-309.4486251744713},{-37.86395058279757,-289.4486251744713},{-37.86395058279757,-269.4486251744713},{-37.86395058279757,-249.44862517447132},{-37.86395058279757,-229.44862517447132},{-37.86395058279757,-209.44862517447132},{-37.86395058279757,-189.44862517447132},{-37.86395058279757,-169.44862517447132},{-37.86395058279757,-149.44862517447132},{-37.86395058279757,-129.44862517447132},{-37.86395058279757,-109.44862517447132},{-37.86395058279757,-89.44862517447132},{-37.86395058279757,-69.44862517447132},{-37.86395058279757,-49.44862517447132},{-37.86395058279757,-29.448625174471317},{-37.86395058279757,-9.448625174471317},{-37.86395058279757,10.551374825528683},{-37.86395058279757,30.551374825528683},{-37.86395058279757,50.55137482552868},{-37.86395058279757,70.55137482552868},{-37.86395058279757,90.55137482552868},{-37.86395058279757,110.55137482552868},{-37.86395058279757,130.55137482552868},{-37.86395058279757,150.55137482552868},{-37.86395058279757,170.55137482552868},{-37.86395058279757,190.55137482552868},{-37.86395058279757,210.55137482552868},{-37.86395058279757,230.55137482552868},{-37.86395058279757,250.55137482552868},{-37.86395058279757,270.5513748255287},{-37.86395058279757,290.5513748255287},{-17.86395058279757,290.5513748255287},{2.136049417202429,290.5513748255287},{22.13604941720243,290.5513748255287}},color={0,0,127}));
  connect(THeaWatSet_d05d6fdc.y,heaInd_e5bf5b65.TSetBuiSup)
    annotation (Line(points={{-27.16591502424174,-527.6223343174202},{-7.165915024241741,-527.6223343174202},{-7.165915024241741,-507.62233431742015},{-7.165915024241741,-487.62233431742015},{-7.165915024241741,-467.62233431742015},{-7.165915024241741,-447.62233431742015},{-7.165915024241741,-427.62233431742015},{-7.165915024241741,-407.62233431742015},{-7.165915024241741,-387.62233431742015},{-7.165915024241741,-367.62233431742015},{-7.165915024241741,-347.62233431742015},{-7.165915024241741,-327.62233431742015},{-7.165915024241741,-307.62233431742015},{-7.165915024241741,-287.62233431742015},{-7.165915024241741,-267.62233431742015},{-7.165915024241741,-247.62233431742015},{-7.165915024241741,-227.62233431742015},{-7.165915024241741,-207.62233431742015},{-7.165915024241741,-187.62233431742015},{-7.165915024241741,-167.62233431742015},{-7.165915024241741,-147.62233431742015},{-7.165915024241741,-127.62233431742015},{-7.165915024241741,-107.62233431742015},{-7.165915024241741,-87.62233431742015},{-7.165915024241741,-67.62233431742015},{-7.165915024241741,-47.622334317420155},{-7.165915024241741,-27.622334317420155},{-7.165915024241741,-7.6223343174201545},{-7.165915024241741,12.377665682579845},{-7.165915024241741,32.377665682579845},{-7.165915024241741,52.377665682579845},{-7.165915024241741,72.37766568257985},{-7.165915024241741,92.37766568257985},{-7.165915024241741,112.37766568257985},{-7.165915024241741,132.37766568257985},{-7.165915024241741,152.37766568257985},{-7.165915024241741,172.37766568257985},{-7.165915024241741,192.37766568257985},{-7.165915024241741,212.37766568257985},{-7.165915024241741,232.37766568257985},{-7.165915024241741,252.37766568257985},{-7.165915024241741,272.37766568257985},{-7.165915024241741,292.37766568257985},{12.834084975758259,292.37766568257985}},color={0,0,127}));

  //
  // End Connect Statements for d05d6fdc
  //



  //
  // Begin Connect Statements for f41d9adc
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[7],heaInd_e5bf5b65.port_a1)
    annotation (Line(points={{-21.82382468369974,717.6892035659085},{-21.82382468369974,697.6892035659085},{-21.82382468369974,677.6892035659084},{-21.82382468369974,657.6892035659084},{-21.82382468369974,637.6892035659084},{-21.82382468369974,617.6892035659084},{-21.82382468369974,597.6892035659084},{-21.82382468369974,577.6892035659084},{-21.82382468369974,557.6892035659084},{-21.82382468369974,537.6892035659084},{-21.82382468369974,517.6892035659084},{-21.82382468369974,497.6892035659085},{-21.82382468369974,477.6892035659085},{-21.82382468369974,457.6892035659085},{-21.82382468369974,437.6892035659085},{-21.82382468369974,417.6892035659085},{-21.82382468369974,397.6892035659085},{-21.82382468369974,377.6892035659085},{-21.82382468369974,357.6892035659085},{-21.82382468369974,337.6892035659085},{-21.82382468369974,317.6892035659085},{-21.82382468369974,297.68920356590854},{-1.8238246836997405,297.68920356590854},{18.17617531630026,297.68920356590854}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[7],heaInd_e5bf5b65.port_b1)
    annotation (Line(points={{-13.329235511459729,728.5891181920339},{-13.329235511459729,708.5891181920339},{-13.329235511459729,688.5891181920339},{-13.329235511459729,668.5891181920338},{-13.329235511459729,648.5891181920338},{-13.329235511459729,628.5891181920338},{-13.329235511459729,608.5891181920338},{-13.329235511459729,588.5891181920338},{-13.329235511459729,568.5891181920338},{-13.329235511459729,548.5891181920338},{-13.329235511459729,528.5891181920338},{-13.329235511459729,508.5891181920338},{-13.329235511459729,488.5891181920338},{-13.329235511459729,468.5891181920338},{-13.329235511459729,448.5891181920338},{-13.329235511459729,428.5891181920338},{-13.329235511459729,408.5891181920338},{-13.329235511459729,388.5891181920338},{-13.329235511459729,368.5891181920338},{-13.329235511459729,348.5891181920338},{-13.329235511459729,328.5891181920338},{-13.329235511459729,308.5891181920338},{6.6707644885402715,308.5891181920338},{26.67076448854027,308.5891181920338}},color={0,0,127}));

  //
  // End Connect Statements for f41d9adc
  //



  //
  // Begin Connect Statements for 5db929b9
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_1bcd3162.ports_bChiWat[1], cooInd_23a4061b.port_a2)
    annotation (Line(points={{67.98224105390355,191.49866808129286},{67.98224105390355,171.49866808129286},{47.98224105390355,171.49866808129286},{27.98224105390355,171.49866808129286}},color={0,0,127}));
  connect(cooInd_23a4061b.port_b2,TimeSerLoa_1bcd3162.ports_aChiWat[1])
    annotation (Line(points={{28.726502846367822,197.60413401202027},{48.72650284636782,197.60413401202027},{48.72650284636782,217.60413401202027},{68.72650284636782,217.60413401202027}},color={0,0,127}));
  connect(pressure_source_5db929b9.ports[1], cooInd_23a4061b.port_b2)
    annotation (Line(points={{27.512838500625634,-528.1434630261676},{7.512838500625634,-528.1434630261676},{7.512838500625634,-508.14346302616764},{7.512838500625634,-488.14346302616764},{7.512838500625634,-468.14346302616764},{7.512838500625634,-448.14346302616764},{7.512838500625634,-428.14346302616764},{7.512838500625634,-408.14346302616764},{7.512838500625634,-388.14346302616764},{7.512838500625634,-368.14346302616764},{7.512838500625634,-348.14346302616764},{7.512838500625634,-328.14346302616764},{7.512838500625634,-308.14346302616764},{7.512838500625634,-288.14346302616764},{7.512838500625634,-268.14346302616764},{7.512838500625634,-248.14346302616764},{7.512838500625634,-228.14346302616764},{7.512838500625634,-208.14346302616764},{7.512838500625634,-188.14346302616764},{7.512838500625634,-168.14346302616764},{7.512838500625634,-148.14346302616764},{7.512838500625634,-128.14346302616764},{7.512838500625634,-108.14346302616764},{7.512838500625634,-88.14346302616764},{7.512838500625634,-68.14346302616764},{7.512838500625634,-48.14346302616764},{7.512838500625634,-28.143463026167638},{7.512838500625634,-8.143463026167638},{7.512838500625634,11.856536973832362},{7.512838500625634,31.856536973832362},{7.512838500625634,51.85653697383236},{7.512838500625634,71.85653697383236},{7.512838500625634,91.85653697383236},{7.512838500625634,111.85653697383236},{7.512838500625634,131.85653697383236},{7.512838500625634,151.85653697383236},{7.512838500625634,171.85653697383236},{27.512838500625634,171.85653697383236}},color={0,0,127}));
  connect(TChiWatSet_5db929b9.y,cooInd_23a4061b.TSetBuiSup)
    annotation (Line(points={{60.34474396248845,-526.997499616361},{40.34474396248845,-526.997499616361},{40.34474396248845,-506.997499616361},{40.34474396248845,-486.997499616361},{40.34474396248845,-466.997499616361},{40.34474396248845,-446.997499616361},{40.34474396248845,-426.997499616361},{40.34474396248845,-406.997499616361},{40.34474396248845,-386.997499616361},{40.34474396248845,-366.997499616361},{40.34474396248845,-346.997499616361},{40.34474396248845,-326.997499616361},{40.34474396248845,-306.997499616361},{40.34474396248845,-286.997499616361},{40.34474396248845,-266.997499616361},{40.34474396248845,-246.99749961636098},{40.34474396248845,-226.99749961636098},{40.34474396248845,-206.99749961636098},{40.34474396248845,-186.99749961636098},{40.34474396248845,-166.99749961636098},{40.34474396248845,-146.99749961636098},{40.34474396248845,-126.99749961636098},{40.34474396248845,-106.99749961636098},{40.34474396248845,-86.99749961636098},{40.34474396248845,-66.99749961636098},{40.34474396248845,-46.99749961636098},{40.34474396248845,-26.997499616360983},{40.34474396248845,-6.997499616360983},{40.34474396248845,13.002500383639017},{40.34474396248845,33.00250038363902},{40.34474396248845,53.00250038363902},{40.34474396248845,73.00250038363902},{40.34474396248845,93.00250038363902},{40.34474396248845,113.00250038363902},{40.34474396248845,133.00250038363902},{40.34474396248845,153.00250038363902},{40.34474396248845,173.00250038363902},{40.34474396248845,193.00250038363902},{40.34474396248845,213.00250038363902},{60.34474396248845,213.00250038363902}},color={0,0,127}));

  //
  // End Connect Statements for 5db929b9
  //



  //
  // Begin Connect Statements for de537ca4
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[8],cooInd_23a4061b.port_a1)
    annotation (Line(points={{-20.378043760330883,751.1281869703646},{-0.3780437603308826,751.1281869703646},{-0.3780437603308826,731.1281869703646},{-0.3780437603308826,711.1281869703646},{-0.3780437603308826,691.1281869703646},{-0.3780437603308826,671.1281869703646},{-0.3780437603308826,651.1281869703646},{-0.3780437603308826,631.1281869703646},{-0.3780437603308826,611.1281869703646},{-0.3780437603308826,591.1281869703646},{-0.3780437603308826,571.1281869703646},{-0.3780437603308826,551.1281869703646},{-0.3780437603308826,531.1281869703646},{-0.3780437603308826,511.12818697036454},{-0.3780437603308826,491.12818697036454},{-0.3780437603308826,471.12818697036454},{-0.3780437603308826,451.12818697036454},{-0.3780437603308826,431.12818697036454},{-0.3780437603308826,411.12818697036454},{-0.3780437603308826,391.12818697036454},{-0.3780437603308826,371.12818697036454},{-0.3780437603308826,351.12818697036454},{-0.3780437603308826,331.12818697036454},{-0.3780437603308826,311.12818697036454},{-0.3780437603308826,291.1281869703646},{-0.3780437603308826,271.1281869703646},{-0.3780437603308826,251.1281869703646},{-0.3780437603308826,231.1281869703646},{-0.3780437603308826,211.1281869703646},{-0.3780437603308826,191.1281869703646},{-0.3780437603308826,171.1281869703646},{19.621956239669117,171.1281869703646}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[8],cooInd_23a4061b.port_b1)
    annotation (Line(points={{-23.839372365844483,764.8462203978729},{-3.8393723658444827,764.8462203978729},{-3.8393723658444827,744.8462203978729},{-3.8393723658444827,724.8462203978729},{-3.8393723658444827,704.8462203978729},{-3.8393723658444827,684.8462203978729},{-3.8393723658444827,664.8462203978729},{-3.8393723658444827,644.8462203978729},{-3.8393723658444827,624.8462203978729},{-3.8393723658444827,604.8462203978729},{-3.8393723658444827,584.8462203978729},{-3.8393723658444827,564.8462203978729},{-3.8393723658444827,544.8462203978729},{-3.8393723658444827,524.8462203978729},{-3.8393723658444827,504.84622039787286},{-3.8393723658444827,484.84622039787286},{-3.8393723658444827,464.84622039787286},{-3.8393723658444827,444.84622039787286},{-3.8393723658444827,424.84622039787286},{-3.8393723658444827,404.84622039787286},{-3.8393723658444827,384.84622039787286},{-3.8393723658444827,364.84622039787286},{-3.8393723658444827,344.84622039787286},{-3.8393723658444827,324.84622039787286},{-3.8393723658444827,304.84622039787286},{-3.8393723658444827,284.8462203978729},{-3.8393723658444827,264.8462203978729},{-3.8393723658444827,244.8462203978729},{-3.8393723658444827,224.8462203978729},{-3.8393723658444827,204.8462203978729},{-3.8393723658444827,184.8462203978729},{16.160627634155517,184.8462203978729}},color={0,0,127}));

  //
  // End Connect Statements for de537ca4
  //



  //
  // Begin Connect Statements for fe21ec2e
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_1bcd3162.ports_bHeaWat[1], heaInd_c3a33ae9.port_a2)
    annotation (Line(points={{47.9689739244792,228.81821867253495},{27.9689739244792,228.81821867253495}},color={0,0,127}));
  connect(heaInd_c3a33ae9.port_b2,TimeSerLoa_1bcd3162.ports_aHeaWat[1])
    annotation (Line(points={{31.941070076773556,227.24081253251404},{51.94107007677357,227.24081253251404}},color={0,0,127}));
  connect(pressure_source_fe21ec2e.ports[1], heaInd_c3a33ae9.port_b2)
    annotation (Line(points={{-64.61995603030428,-560.8994646215215},{-44.61995603030429,-560.8994646215215},{-44.61995603030429,-540.8994646215215},{-44.61995603030429,-520.8994646215215},{-44.61995603030429,-500.8994646215215},{-44.61995603030429,-480.8994646215215},{-44.61995603030429,-460.8994646215215},{-44.61995603030429,-440.8994646215215},{-44.61995603030429,-420.8994646215215},{-44.61995603030429,-400.8994646215215},{-44.61995603030429,-380.8994646215215},{-44.61995603030429,-360.8994646215215},{-44.61995603030429,-340.8994646215215},{-44.61995603030429,-320.8994646215215},{-44.61995603030429,-300.8994646215215},{-44.61995603030429,-280.8994646215215},{-44.61995603030429,-260.8994646215215},{-44.61995603030429,-240.89946462152147},{-44.61995603030429,-220.89946462152147},{-44.61995603030429,-200.89946462152136},{-44.61995603030429,-180.89946462152136},{-44.61995603030429,-160.89946462152136},{-44.61995603030429,-140.89946462152136},{-44.61995603030429,-120.89946462152136},{-44.61995603030429,-100.89946462152136},{-44.61995603030429,-80.89946462152136},{-44.61995603030429,-60.89946462152136},{-44.61995603030429,-40.89946462152136},{-44.61995603030429,-20.89946462152136},{-44.61995603030429,-0.8994646215213606},{-44.61995603030429,19.10053537847864},{-44.61995603030429,39.10053537847864},{-44.61995603030429,59.10053537847864},{-44.61995603030429,79.10053537847864},{-44.61995603030429,99.10053537847864},{-44.61995603030429,119.10053537847864},{-44.61995603030429,139.10053537847864},{-44.61995603030429,159.10053537847864},{-44.61995603030429,179.10053537847864},{-44.61995603030429,199.10053537847864},{-44.61995603030429,219.10053537847864},{-24.61995603030428,219.10053537847864},{-4.61995603030428,219.10053537847864},{15.38004396969572,219.10053537847864}},color={0,0,127}));
  connect(THeaWatSet_fe21ec2e.y,heaInd_c3a33ae9.TSetBuiSup)
    annotation (Line(points={{-13.512689931210645,-569.3972234469004},{6.4873100687893555,-569.3972234469004},{6.4873100687893555,-549.3972234469004},{6.4873100687893555,-529.3972234469004},{6.4873100687893555,-509.3972234469004},{6.4873100687893555,-489.3972234469004},{6.4873100687893555,-469.3972234469004},{6.4873100687893555,-449.3972234469004},{6.4873100687893555,-429.3972234469004},{6.4873100687893555,-409.3972234469004},{6.4873100687893555,-389.3972234469004},{6.4873100687893555,-369.3972234469004},{6.4873100687893555,-349.3972234469004},{6.4873100687893555,-329.3972234469004},{6.4873100687893555,-309.3972234469004},{6.4873100687893555,-289.3972234469004},{6.4873100687893555,-269.3972234469004},{6.4873100687893555,-249.3972234469004},{6.4873100687893555,-229.3972234469004},{6.4873100687893555,-209.3972234469004},{6.4873100687893555,-189.3972234469004},{6.4873100687893555,-169.3972234469004},{6.4873100687893555,-149.3972234469004},{6.4873100687893555,-129.3972234469004},{6.4873100687893555,-109.3972234469004},{6.4873100687893555,-89.3972234469004},{6.4873100687893555,-69.3972234469004},{6.4873100687893555,-49.3972234469004},{6.4873100687893555,-29.397223446900398},{6.4873100687893555,-9.397223446900398},{6.4873100687893555,10.602776553099602},{6.4873100687893555,30.602776553099602},{6.4873100687893555,50.6027765530996},{6.4873100687893555,70.6027765530996},{6.4873100687893555,90.6027765530996},{6.4873100687893555,110.6027765530996},{6.4873100687893555,130.6027765530996},{6.4873100687893555,150.6027765530996},{6.4873100687893555,170.6027765530996},{6.4873100687893555,190.6027765530996},{6.4873100687893555,210.6027765530996},{26.487310068789355,210.6027765530996}},color={0,0,127}));

  //
  // End Connect Statements for fe21ec2e
  //



  //
  // Begin Connect Statements for 908ab319
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[8],heaInd_c3a33ae9.port_a1)
    annotation (Line(points={{-10.603864057742825,725.5497854013253},{-10.603864057742825,705.5497854013253},{-10.603864057742825,685.5497854013253},{-10.603864057742825,665.5497854013252},{-10.603864057742825,645.5497854013252},{-10.603864057742825,625.5497854013252},{-10.603864057742825,605.5497854013252},{-10.603864057742825,585.5497854013252},{-10.603864057742825,565.5497854013252},{-10.603864057742825,545.5497854013252},{-10.603864057742825,525.5497854013252},{-10.603864057742825,505.5497854013252},{-10.603864057742825,485.5497854013252},{-10.603864057742825,465.5497854013252},{-10.603864057742825,445.5497854013252},{-10.603864057742825,425.5497854013252},{-10.603864057742825,405.5497854013252},{-10.603864057742825,385.5497854013252},{-10.603864057742825,365.5497854013252},{-10.603864057742825,345.5497854013252},{-10.603864057742825,325.5497854013252},{-10.603864057742825,305.5497854013252},{-10.603864057742825,285.54978540132527},{-10.603864057742825,265.54978540132527},{-10.603864057742825,245.54978540132527},{-10.603864057742825,225.54978540132527},{9.396135942257175,225.54978540132527},{29.396135942257175,225.54978540132527}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[8],heaInd_c3a33ae9.port_b1)
    annotation (Line(points={{-16.799269620777565,723.8455717016617},{-16.799269620777565,703.8455717016617},{-16.799269620777565,683.8455717016617},{-16.799269620777565,663.8455717016617},{-16.799269620777565,643.8455717016617},{-16.799269620777565,623.8455717016617},{-16.799269620777565,603.8455717016617},{-16.799269620777565,583.8455717016617},{-16.799269620777565,563.8455717016617},{-16.799269620777565,543.8455717016616},{-16.799269620777565,523.8455717016616},{-16.799269620777565,503.84557170166164},{-16.799269620777565,483.84557170166164},{-16.799269620777565,463.84557170166164},{-16.799269620777565,443.84557170166164},{-16.799269620777565,423.84557170166164},{-16.799269620777565,403.84557170166164},{-16.799269620777565,383.84557170166164},{-16.799269620777565,363.84557170166164},{-16.799269620777565,343.84557170166164},{-16.799269620777565,323.84557170166164},{-16.799269620777565,303.84557170166164},{-16.799269620777565,283.8455717016617},{-16.799269620777565,263.8455717016617},{-16.799269620777565,243.8455717016617},{-16.799269620777565,223.8455717016617},{3.200730379222435,223.8455717016617},{23.200730379222435,223.8455717016617}},color={0,0,127}));

  //
  // End Connect Statements for 908ab319
  //



  //
  // Begin Connect Statements for f45d602b
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_fec0cb2b.ports_bChiWat[1], cooInd_c4dbbad6.port_a2)
    annotation (Line(points={{64.81005720374682,118.87705669782531},{64.81005720374682,98.87705669782531},{44.81005720374682,98.87705669782531},{24.81005720374681,98.87705669782531}},color={0,0,127}));
  connect(cooInd_c4dbbad6.port_b2,TimeSerLoa_fec0cb2b.ports_aChiWat[1])
    annotation (Line(points={{17.50437397226341,125.16574669629051},{37.50437397226341,125.16574669629051},{37.50437397226341,145.1657466962905},{57.50437397226341,145.1657466962905}},color={0,0,127}));
  connect(pressure_source_f45d602b.ports[1], cooInd_c4dbbad6.port_b2)
    annotation (Line(points={{12.74805423076046,-550.6397514163439},{-7.251945769239541,-550.6397514163439},{-7.251945769239541,-530.6397514163439},{-7.251945769239541,-510.63975141634387},{-7.251945769239541,-490.63975141634387},{-7.251945769239541,-470.63975141634387},{-7.251945769239541,-450.63975141634387},{-7.251945769239541,-430.63975141634387},{-7.251945769239541,-410.63975141634387},{-7.251945769239541,-390.63975141634387},{-7.251945769239541,-370.63975141634387},{-7.251945769239541,-350.63975141634387},{-7.251945769239541,-330.63975141634387},{-7.251945769239541,-310.63975141634387},{-7.251945769239541,-290.63975141634387},{-7.251945769239541,-270.63975141634387},{-7.251945769239541,-250.63975141634387},{-7.251945769239541,-230.63975141634387},{-7.251945769239541,-210.63975141634387},{-7.251945769239541,-190.63975141634387},{-7.251945769239541,-170.63975141634387},{-7.251945769239541,-150.63975141634387},{-7.251945769239541,-130.63975141634387},{-7.251945769239541,-110.63975141634387},{-7.251945769239541,-90.63975141634387},{-7.251945769239541,-70.63975141634387},{-7.251945769239541,-50.63975141634387},{-7.251945769239541,-30.63975141634387},{-7.251945769239541,-10.63975141634387},{-7.251945769239541,9.36024858365613},{-7.251945769239541,29.36024858365613},{-7.251945769239541,49.36024858365613},{-7.251945769239541,69.36024858365613},{-7.251945769239541,89.36024858365613},{-7.251945769239541,109.36024858365613},{12.74805423076046,109.36024858365613}},color={0,0,127}));
  connect(TChiWatSet_f45d602b.y,cooInd_c4dbbad6.TSetBuiSup)
    annotation (Line(points={{59.858934059609794,-562.8648874390467},{39.858934059609794,-562.8648874390467},{39.858934059609794,-542.8648874390467},{39.858934059609794,-522.8648874390467},{39.858934059609794,-502.8648874390467},{39.858934059609794,-482.8648874390467},{39.858934059609794,-462.8648874390467},{39.858934059609794,-442.8648874390467},{39.858934059609794,-422.8648874390467},{39.858934059609794,-402.8648874390467},{39.858934059609794,-382.8648874390467},{39.858934059609794,-362.8648874390467},{39.858934059609794,-342.8648874390467},{39.858934059609794,-322.8648874390467},{39.858934059609794,-302.8648874390467},{39.858934059609794,-282.8648874390467},{39.858934059609794,-262.8648874390467},{39.858934059609794,-242.8648874390467},{39.858934059609794,-222.8648874390467},{39.858934059609794,-202.8648874390468},{39.858934059609794,-182.8648874390468},{39.858934059609794,-162.8648874390468},{39.858934059609794,-142.8648874390468},{39.858934059609794,-122.86488743904681},{39.858934059609794,-102.86488743904681},{39.858934059609794,-82.86488743904681},{39.858934059609794,-62.86488743904681},{39.858934059609794,-42.86488743904681},{39.858934059609794,-22.86488743904681},{39.858934059609794,-2.864887439046811},{39.858934059609794,17.13511256095319},{39.858934059609794,37.13511256095319},{39.858934059609794,57.13511256095319},{39.858934059609794,77.13511256095319},{39.858934059609794,97.13511256095319},{39.858934059609794,117.13511256095319},{39.858934059609794,137.1351125609532},{59.858934059609794,137.1351125609532}},color={0,0,127}));

  //
  // End Connect Statements for f45d602b
  //



  //
  // Begin Connect Statements for de15f740
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[9],cooInd_c4dbbad6.port_a1)
    annotation (Line(points={{-27.68301069674103,760.0120426547801},{-7.683010696741036,760.0120426547801},{-7.683010696741036,740.0120426547801},{-7.683010696741036,720.0120426547801},{-7.683010696741036,700.0120426547801},{-7.683010696741036,680.0120426547801},{-7.683010696741036,660.0120426547801},{-7.683010696741036,640.0120426547801},{-7.683010696741036,620.0120426547801},{-7.683010696741036,600.0120426547801},{-7.683010696741036,580.0120426547801},{-7.683010696741036,560.0120426547801},{-7.683010696741036,540.0120426547801},{-7.683010696741036,520.0120426547801},{-7.683010696741036,500.01204265478003},{-7.683010696741036,480.01204265478003},{-7.683010696741036,460.01204265478003},{-7.683010696741036,440.01204265478003},{-7.683010696741036,420.01204265478003},{-7.683010696741036,400.01204265478003},{-7.683010696741036,380.01204265478003},{-7.683010696741036,360.01204265478003},{-7.683010696741036,340.01204265478003},{-7.683010696741036,320.01204265478003},{-7.683010696741036,300.01204265478003},{-7.683010696741036,280.01204265478},{-7.683010696741036,260.01204265478},{-7.683010696741036,240.01204265477998},{-7.683010696741036,220.01204265477998},{-7.683010696741036,200.01204265477998},{-7.683010696741036,180.01204265477998},{-7.683010696741036,160.01204265477998},{-7.683010696741036,140.01204265477998},{-7.683010696741036,120.01204265477998},{-7.683010696741036,100.01204265477998},{12.316989303258964,100.01204265477998}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[9],cooInd_c4dbbad6.port_b1)
    annotation (Line(points={{-27.375638156233876,764.4754176297199},{-7.375638156233876,764.4754176297199},{-7.375638156233876,744.4754176297199},{-7.375638156233876,724.4754176297199},{-7.375638156233876,704.4754176297199},{-7.375638156233876,684.4754176297199},{-7.375638156233876,664.4754176297199},{-7.375638156233876,644.4754176297199},{-7.375638156233876,624.4754176297199},{-7.375638156233876,604.4754176297199},{-7.375638156233876,584.4754176297199},{-7.375638156233876,564.4754176297199},{-7.375638156233876,544.4754176297199},{-7.375638156233876,524.4754176297199},{-7.375638156233876,504.4754176297199},{-7.375638156233876,484.4754176297199},{-7.375638156233876,464.4754176297199},{-7.375638156233876,444.4754176297199},{-7.375638156233876,424.4754176297199},{-7.375638156233876,404.4754176297199},{-7.375638156233876,384.4754176297199},{-7.375638156233876,364.4754176297199},{-7.375638156233876,344.4754176297199},{-7.375638156233876,324.4754176297199},{-7.375638156233876,304.4754176297199},{-7.375638156233876,284.4754176297199},{-7.375638156233876,264.4754176297199},{-7.375638156233876,244.4754176297199},{-7.375638156233876,224.4754176297199},{-7.375638156233876,204.4754176297199},{-7.375638156233876,184.4754176297199},{-7.375638156233876,164.4754176297199},{-7.375638156233876,144.4754176297199},{-7.375638156233876,124.47541762971991},{-7.375638156233876,104.47541762971991},{12.624361843766124,104.47541762971991}},color={0,0,127}));

  //
  // End Connect Statements for de15f740
  //



  //
  // Begin Connect Statements for 6e9a1cf3
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_fec0cb2b.ports_bHeaWat[1], heaInd_84951389.port_a2)
    annotation (Line(points={{47.70153932337243,142.01314701927822},{27.70153932337243,142.01314701927822}},color={0,0,127}));
  connect(heaInd_84951389.port_b2,TimeSerLoa_fec0cb2b.ports_aHeaWat[1])
    annotation (Line(points={{31.823555436014445,135.80802406050532},{51.82355543601446,135.80802406050532}},color={0,0,127}));
  connect(pressure_source_6e9a1cf3.ports[1], heaInd_84951389.port_b2)
    annotation (Line(points={{-50.57981056119155,-603.8802638207858},{-30.57981056119155,-603.8802638207858},{-30.57981056119155,-583.8802638207858},{-30.57981056119155,-563.8802638207858},{-30.57981056119155,-543.8802638207858},{-30.57981056119155,-523.8802638207858},{-30.57981056119155,-503.8802638207858},{-30.57981056119155,-483.8802638207858},{-30.57981056119155,-463.8802638207858},{-30.57981056119155,-443.8802638207858},{-30.57981056119155,-423.8802638207858},{-30.57981056119155,-403.8802638207858},{-30.57981056119155,-383.8802638207858},{-30.57981056119155,-363.8802638207858},{-30.57981056119155,-343.8802638207858},{-30.57981056119155,-323.8802638207858},{-30.57981056119155,-303.8802638207858},{-30.57981056119155,-283.8802638207858},{-30.57981056119155,-263.8802638207858},{-30.57981056119155,-243.88026382078579},{-30.57981056119155,-223.88026382078579},{-30.57981056119155,-203.88026382078567},{-30.57981056119155,-183.88026382078567},{-30.57981056119155,-163.88026382078567},{-30.57981056119155,-143.88026382078567},{-30.57981056119155,-123.88026382078567},{-30.57981056119155,-103.88026382078567},{-30.57981056119155,-83.88026382078567},{-30.57981056119155,-63.88026382078567},{-30.57981056119155,-43.88026382078567},{-30.57981056119155,-23.88026382078567},{-30.57981056119155,-3.8802638207856717},{-30.57981056119155,16.11973617921433},{-30.57981056119155,36.11973617921433},{-30.57981056119155,56.11973617921433},{-30.57981056119155,76.11973617921433},{-30.57981056119155,96.11973617921433},{-30.57981056119155,116.11973617921433},{-30.57981056119155,136.11973617921433},{-10.57981056119155,136.11973617921433},{9.42018943880845,136.11973617921433},{29.42018943880845,136.11973617921433}},color={0,0,127}));
  connect(THeaWatSet_6e9a1cf3.y,heaInd_84951389.TSetBuiSup)
    annotation (Line(points={{-26.987280248280186,-600.4937048874533},{-6.987280248280186,-600.4937048874533},{-6.987280248280186,-580.4937048874533},{-6.987280248280186,-560.4937048874533},{-6.987280248280186,-540.4937048874533},{-6.987280248280186,-520.4937048874533},{-6.987280248280186,-500.4937048874533},{-6.987280248280186,-480.4937048874533},{-6.987280248280186,-460.4937048874533},{-6.987280248280186,-440.4937048874533},{-6.987280248280186,-420.4937048874533},{-6.987280248280186,-400.4937048874533},{-6.987280248280186,-380.4937048874533},{-6.987280248280186,-360.4937048874533},{-6.987280248280186,-340.4937048874533},{-6.987280248280186,-320.4937048874533},{-6.987280248280186,-300.4937048874533},{-6.987280248280186,-280.4937048874533},{-6.987280248280186,-260.4937048874533},{-6.987280248280186,-240.4937048874533},{-6.987280248280186,-220.4937048874533},{-6.987280248280186,-200.4937048874532},{-6.987280248280186,-180.4937048874532},{-6.987280248280186,-160.4937048874532},{-6.987280248280186,-140.4937048874532},{-6.987280248280186,-120.49370488745319},{-6.987280248280186,-100.49370488745319},{-6.987280248280186,-80.49370488745319},{-6.987280248280186,-60.49370488745319},{-6.987280248280186,-40.49370488745319},{-6.987280248280186,-20.49370488745319},{-6.987280248280186,-0.4937048874531911},{-6.987280248280186,19.50629511254681},{-6.987280248280186,39.50629511254681},{-6.987280248280186,59.50629511254681},{-6.987280248280186,79.50629511254681},{-6.987280248280186,99.50629511254681},{-6.987280248280186,119.50629511254681},{-6.987280248280186,139.5062951125468},{13.012719751719814,139.5062951125468}},color={0,0,127}));

  //
  // End Connect Statements for 6e9a1cf3
  //



  //
  // Begin Connect Statements for b969f858
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[9],heaInd_84951389.port_a1)
    annotation (Line(points={{-21.671483323560125,722.0360515353568},{-21.671483323560125,702.0360515353568},{-21.671483323560125,682.0360515353568},{-21.671483323560125,662.0360515353568},{-21.671483323560125,642.0360515353568},{-21.671483323560125,622.0360515353568},{-21.671483323560125,602.0360515353568},{-21.671483323560125,582.0360515353568},{-21.671483323560125,562.0360515353568},{-21.671483323560125,542.0360515353568},{-21.671483323560125,522.0360515353568},{-21.671483323560125,502.03605153535676},{-21.671483323560125,482.03605153535676},{-21.671483323560125,462.03605153535676},{-21.671483323560125,442.03605153535676},{-21.671483323560125,422.03605153535676},{-21.671483323560125,402.03605153535676},{-21.671483323560125,382.03605153535676},{-21.671483323560125,362.03605153535676},{-21.671483323560125,342.03605153535676},{-21.671483323560125,322.03605153535676},{-21.671483323560125,302.03605153535676},{-21.671483323560125,282.0360515353568},{-21.671483323560125,262.0360515353568},{-21.671483323560125,242.03605153535682},{-21.671483323560125,222.03605153535682},{-21.671483323560125,202.03605153535682},{-21.671483323560125,182.03605153535682},{-21.671483323560125,162.03605153535682},{-21.671483323560125,142.03605153535682},{-1.6714833235601247,142.03605153535682},{18.328516676439875,142.03605153535682}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[9],heaInd_84951389.port_b1)
    annotation (Line(points={{-13.042816991655613,718.4917483510964},{-13.042816991655613,698.4917483510964},{-13.042816991655613,678.4917483510964},{-13.042816991655613,658.4917483510964},{-13.042816991655613,638.4917483510964},{-13.042816991655613,618.4917483510964},{-13.042816991655613,598.4917483510964},{-13.042816991655613,578.4917483510964},{-13.042816991655613,558.4917483510964},{-13.042816991655613,538.4917483510964},{-13.042816991655613,518.4917483510964},{-13.042816991655613,498.49174835109636},{-13.042816991655613,478.49174835109636},{-13.042816991655613,458.49174835109636},{-13.042816991655613,438.49174835109636},{-13.042816991655613,418.49174835109636},{-13.042816991655613,398.49174835109636},{-13.042816991655613,378.49174835109636},{-13.042816991655613,358.49174835109636},{-13.042816991655613,338.49174835109636},{-13.042816991655613,318.49174835109636},{-13.042816991655613,298.49174835109636},{-13.042816991655613,278.49174835109636},{-13.042816991655613,258.49174835109636},{-13.042816991655613,238.49174835109636},{-13.042816991655613,218.49174835109636},{-13.042816991655613,198.49174835109636},{-13.042816991655613,178.49174835109636},{-13.042816991655613,158.49174835109636},{-13.042816991655613,138.49174835109636},{6.957183008344387,138.49174835109636},{26.957183008344387,138.49174835109636}},color={0,0,127}));

  //
  // End Connect Statements for b969f858
  //



  //
  // Begin Connect Statements for a7cc180f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_f0ceaaf3.ports_bChiWat[1], cooInd_a4d657a9.port_a2)
    annotation (Line(points={{60.74742469955336,39.79181386987955},{60.74742469955336,19.791813869879547},{40.74742469955336,19.791813869879547},{20.747424699553363,19.791813869879547}},color={0,0,127}));
  connect(cooInd_a4d657a9.port_b2,TimeSerLoa_f0ceaaf3.ports_aChiWat[1])
    annotation (Line(points={{16.359831411678172,40.90966459542619},{36.35983141167817,40.90966459542619},{36.35983141167817,60.90966459542619},{56.35983141167816,60.90966459542619}},color={0,0,127}));
  connect(pressure_source_a7cc180f.ports[1], cooInd_a4d657a9.port_b2)
    annotation (Line(points={{16.110523519874064,-607.0404413829585},{-3.8894764801259356,-607.0404413829585},{-3.8894764801259356,-587.0404413829585},{-3.8894764801259356,-567.0404413829585},{-3.8894764801259356,-547.0404413829585},{-3.8894764801259356,-527.0404413829585},{-3.8894764801259356,-507.04044138295853},{-3.8894764801259356,-487.04044138295853},{-3.8894764801259356,-467.04044138295853},{-3.8894764801259356,-447.04044138295853},{-3.8894764801259356,-427.04044138295853},{-3.8894764801259356,-407.04044138295853},{-3.8894764801259356,-387.04044138295853},{-3.8894764801259356,-367.04044138295853},{-3.8894764801259356,-347.04044138295853},{-3.8894764801259356,-327.04044138295853},{-3.8894764801259356,-307.04044138295853},{-3.8894764801259356,-287.04044138295853},{-3.8894764801259356,-267.04044138295853},{-3.8894764801259356,-247.04044138295853},{-3.8894764801259356,-227.04044138295853},{-3.8894764801259356,-207.04044138295842},{-3.8894764801259356,-187.04044138295842},{-3.8894764801259356,-167.04044138295842},{-3.8894764801259356,-147.04044138295842},{-3.8894764801259356,-127.04044138295842},{-3.8894764801259356,-107.04044138295842},{-3.8894764801259356,-87.04044138295842},{-3.8894764801259356,-67.04044138295842},{-3.8894764801259356,-47.04044138295842},{-3.8894764801259356,-27.04044138295842},{-3.8894764801259356,-7.04044138295842},{-3.8894764801259356,12.95955861704158},{16.110523519874064,12.95955861704158}},color={0,0,127}));
  connect(TChiWatSet_a7cc180f.y,cooInd_a4d657a9.TSetBuiSup)
    annotation (Line(points={{60.74766712387341,-597.0644915927148},{40.74766712387341,-597.0644915927148},{40.74766712387341,-577.0644915927148},{40.74766712387341,-557.0644915927148},{40.74766712387341,-537.0644915927148},{40.74766712387341,-517.0644915927148},{40.74766712387341,-497.06449159271483},{40.74766712387341,-477.06449159271483},{40.74766712387341,-457.06449159271483},{40.74766712387341,-437.06449159271483},{40.74766712387341,-417.06449159271483},{40.74766712387341,-397.06449159271483},{40.74766712387341,-377.06449159271483},{40.74766712387341,-357.06449159271483},{40.74766712387341,-337.06449159271483},{40.74766712387341,-317.06449159271483},{40.74766712387341,-297.06449159271483},{40.74766712387341,-277.06449159271483},{40.74766712387341,-257.06449159271483},{40.74766712387341,-237.06449159271483},{40.74766712387341,-217.06449159271483},{40.74766712387341,-197.06449159271483},{40.74766712387341,-177.06449159271483},{40.74766712387341,-157.06449159271483},{40.74766712387341,-137.06449159271483},{40.74766712387341,-117.06449159271483},{40.74766712387341,-97.06449159271483},{40.74766712387341,-77.06449159271483},{40.74766712387341,-57.06449159271483},{40.74766712387341,-37.06449159271483},{40.74766712387341,-17.06449159271483},{40.74766712387341,2.9355084072851696},{40.74766712387341,22.93550840728517},{40.74766712387341,42.93550840728517},{40.74766712387341,62.93550840728517},{60.74766712387341,62.93550840728517}},color={0,0,127}));

  //
  // End Connect Statements for a7cc180f
  //



  //
  // Begin Connect Statements for 208d7d08
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[10],cooInd_a4d657a9.port_a1)
    annotation (Line(points={{-23.953479114207667,750.0912717919267},{-3.953479114207667,750.0912717919267},{-3.953479114207667,730.0912717919267},{-3.953479114207667,710.0912717919267},{-3.953479114207667,690.0912717919267},{-3.953479114207667,670.0912717919267},{-3.953479114207667,650.0912717919267},{-3.953479114207667,630.0912717919267},{-3.953479114207667,610.0912717919267},{-3.953479114207667,590.0912717919267},{-3.953479114207667,570.0912717919267},{-3.953479114207667,550.0912717919267},{-3.953479114207667,530.0912717919267},{-3.953479114207667,510.0912717919267},{-3.953479114207667,490.0912717919267},{-3.953479114207667,470.0912717919267},{-3.953479114207667,450.0912717919267},{-3.953479114207667,430.0912717919267},{-3.953479114207667,410.0912717919267},{-3.953479114207667,390.0912717919267},{-3.953479114207667,370.0912717919267},{-3.953479114207667,350.0912717919267},{-3.953479114207667,330.0912717919267},{-3.953479114207667,310.0912717919267},{-3.953479114207667,290.0912717919267},{-3.953479114207667,270.0912717919267},{-3.953479114207667,250.09127179192672},{-3.953479114207667,230.09127179192672},{-3.953479114207667,210.09127179192672},{-3.953479114207667,190.09127179192672},{-3.953479114207667,170.09127179192672},{-3.953479114207667,150.09127179192672},{-3.953479114207667,130.09127179192672},{-3.953479114207667,110.09127179192672},{-3.953479114207667,90.09127179192672},{-3.953479114207667,70.09127179192672},{-3.953479114207667,50.091271791926715},{-3.953479114207667,30.091271791926715},{-3.953479114207667,10.091271791926715},{16.046520885792333,10.091271791926715}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[10],cooInd_a4d657a9.port_b1)
    annotation (Line(points={{-14.909459266745301,769.9155816463805},{5.090540733254699,769.9155816463805},{5.090540733254699,749.9155816463805},{5.090540733254699,729.9155816463805},{5.090540733254699,709.9155816463805},{5.090540733254699,689.9155816463805},{5.090540733254699,669.9155816463805},{5.090540733254699,649.9155816463805},{5.090540733254699,629.9155816463805},{5.090540733254699,609.9155816463805},{5.090540733254699,589.9155816463805},{5.090540733254699,569.9155816463805},{5.090540733254699,549.9155816463805},{5.090540733254699,529.9155816463805},{5.090540733254699,509.9155816463805},{5.090540733254699,489.9155816463805},{5.090540733254699,469.9155816463805},{5.090540733254699,449.9155816463805},{5.090540733254699,429.9155816463805},{5.090540733254699,409.9155816463805},{5.090540733254699,389.9155816463805},{5.090540733254699,369.9155816463805},{5.090540733254699,349.9155816463805},{5.090540733254699,329.9155816463805},{5.090540733254699,309.9155816463805},{5.090540733254699,289.9155816463805},{5.090540733254699,269.9155816463805},{5.090540733254699,249.91558164638047},{5.090540733254699,229.91558164638047},{5.090540733254699,209.91558164638047},{5.090540733254699,189.91558164638047},{5.090540733254699,169.91558164638047},{5.090540733254699,149.91558164638047},{5.090540733254699,129.91558164638047},{5.090540733254699,109.91558164638047},{5.090540733254699,89.91558164638047},{5.090540733254699,69.91558164638047},{5.090540733254699,49.915581646380474},{5.090540733254699,29.915581646380474},{25.0905407332547,29.915581646380474}},color={0,0,127}));

  //
  // End Connect Statements for 208d7d08
  //



  //
  // Begin Connect Statements for 6e8abfc2
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_f0ceaaf3.ports_bHeaWat[1], heaInd_2820df07.port_a2)
    annotation (Line(points={{30.41801956564092,59.08419068568128},{10.418019565640918,59.08419068568128}},color={0,0,127}));
  connect(heaInd_2820df07.port_b2,TimeSerLoa_f0ceaaf3.ports_aHeaWat[1])
    annotation (Line(points={{43.27558830842065,54.28396344605176},{63.27558830842065,54.28396344605176}},color={0,0,127}));
  connect(pressure_source_6e8abfc2.ports[1], heaInd_2820df07.port_b2)
    annotation (Line(points={{-50.90935357769453,-644.7978708639364},{-30.90935357769453,-644.7978708639364},{-30.90935357769453,-624.7978708639364},{-30.90935357769453,-604.7978708639364},{-30.90935357769453,-584.7978708639364},{-30.90935357769453,-564.7978708639364},{-30.90935357769453,-544.7978708639364},{-30.90935357769453,-524.7978708639364},{-30.90935357769453,-504.7978708639364},{-30.90935357769453,-484.7978708639364},{-30.90935357769453,-464.7978708639364},{-30.90935357769453,-444.7978708639364},{-30.90935357769453,-424.7978708639364},{-30.90935357769453,-404.7978708639364},{-30.90935357769453,-384.7978708639364},{-30.90935357769453,-364.7978708639364},{-30.90935357769453,-344.7978708639364},{-30.90935357769453,-324.7978708639364},{-30.90935357769453,-304.7978708639364},{-30.90935357769453,-284.7978708639364},{-30.90935357769453,-264.7978708639364},{-30.90935357769453,-244.7978708639364},{-30.90935357769453,-224.7978708639364},{-30.90935357769453,-204.7978708639365},{-30.90935357769453,-184.7978708639365},{-30.90935357769453,-164.7978708639365},{-30.90935357769453,-144.7978708639365},{-30.90935357769453,-124.79787086393651},{-30.90935357769453,-104.79787086393651},{-30.90935357769453,-84.79787086393651},{-30.90935357769453,-64.79787086393651},{-30.90935357769453,-44.79787086393651},{-30.90935357769453,-24.79787086393651},{-30.90935357769453,-4.7978708639365095},{-30.90935357769453,15.20212913606349},{-30.90935357769453,35.20212913606349},{-30.90935357769453,55.20212913606349},{-10.909353577694532,55.20212913606349},{9.090646422305468,55.20212913606349},{29.09064642230547,55.20212913606349}},color={0,0,127}));
  connect(THeaWatSet_6e8abfc2.y,heaInd_2820df07.TSetBuiSup)
    annotation (Line(points={{-21.489157048405445,-646.0805364237326},{-1.4891570484054455,-646.0805364237326},{-1.4891570484054455,-626.0805364237326},{-1.4891570484054455,-606.0805364237326},{-1.4891570484054455,-586.0805364237326},{-1.4891570484054455,-566.0805364237326},{-1.4891570484054455,-546.0805364237326},{-1.4891570484054455,-526.0805364237326},{-1.4891570484054455,-506.0805364237326},{-1.4891570484054455,-486.0805364237326},{-1.4891570484054455,-466.0805364237326},{-1.4891570484054455,-446.0805364237326},{-1.4891570484054455,-426.0805364237326},{-1.4891570484054455,-406.0805364237326},{-1.4891570484054455,-386.0805364237326},{-1.4891570484054455,-366.0805364237326},{-1.4891570484054455,-346.0805364237326},{-1.4891570484054455,-326.0805364237326},{-1.4891570484054455,-306.0805364237326},{-1.4891570484054455,-286.0805364237326},{-1.4891570484054455,-266.0805364237326},{-1.4891570484054455,-246.0805364237326},{-1.4891570484054455,-226.0805364237326},{-1.4891570484054455,-206.08053642373272},{-1.4891570484054455,-186.08053642373272},{-1.4891570484054455,-166.08053642373272},{-1.4891570484054455,-146.08053642373272},{-1.4891570484054455,-126.08053642373272},{-1.4891570484054455,-106.08053642373272},{-1.4891570484054455,-86.08053642373272},{-1.4891570484054455,-66.08053642373272},{-1.4891570484054455,-46.080536423732724},{-1.4891570484054455,-26.080536423732724},{-1.4891570484054455,-6.080536423732724},{-1.4891570484054455,13.919463576267276},{-1.4891570484054455,33.919463576267276},{-1.4891570484054455,53.919463576267276},{18.510842951594555,53.919463576267276}},color={0,0,127}));

  //
  // End Connect Statements for 6e8abfc2
  //



  //
  // Begin Connect Statements for 21c80720
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[10],heaInd_2820df07.port_a1)
    annotation (Line(points={{-21.222808687298738,719.1978752289004},{-21.222808687298738,699.1978752289004},{-21.222808687298738,679.1978752289004},{-21.222808687298738,659.1978752289004},{-21.222808687298738,639.1978752289004},{-21.222808687298738,619.1978752289004},{-21.222808687298738,599.1978752289004},{-21.222808687298738,579.1978752289004},{-21.222808687298738,559.1978752289004},{-21.222808687298738,539.1978752289004},{-21.222808687298738,519.1978752289004},{-21.222808687298738,499.19787522890044},{-21.222808687298738,479.19787522890044},{-21.222808687298738,459.19787522890044},{-21.222808687298738,439.19787522890044},{-21.222808687298738,419.19787522890044},{-21.222808687298738,399.19787522890044},{-21.222808687298738,379.19787522890044},{-21.222808687298738,359.19787522890044},{-21.222808687298738,339.19787522890044},{-21.222808687298738,319.19787522890044},{-21.222808687298738,299.19787522890044},{-21.222808687298738,279.19787522890044},{-21.222808687298738,259.19787522890044},{-21.222808687298738,239.19787522890044},{-21.222808687298738,219.19787522890044},{-21.222808687298738,199.19787522890044},{-21.222808687298738,179.19787522890044},{-21.222808687298738,159.19787522890044},{-21.222808687298738,139.19787522890044},{-21.222808687298738,119.19787522890044},{-21.222808687298738,99.19787522890044},{-21.222808687298738,79.19787522890044},{-21.222808687298738,59.19787522890044},{-1.2228086872987376,59.19787522890044},{18.777191312701262,59.19787522890044}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[10],heaInd_2820df07.port_b1)
    annotation (Line(points={{-24.95112551328647,723.8967785524758},{-24.95112551328647,703.8967785524758},{-24.95112551328647,683.8967785524758},{-24.95112551328647,663.8967785524758},{-24.95112551328647,643.8967785524758},{-24.95112551328647,623.8967785524758},{-24.95112551328647,603.8967785524758},{-24.95112551328647,583.8967785524758},{-24.95112551328647,563.8967785524758},{-24.95112551328647,543.8967785524758},{-24.95112551328647,523.8967785524758},{-24.95112551328647,503.89677855247584},{-24.95112551328647,483.89677855247584},{-24.95112551328647,463.89677855247584},{-24.95112551328647,443.89677855247584},{-24.95112551328647,423.89677855247584},{-24.95112551328647,403.89677855247584},{-24.95112551328647,383.89677855247584},{-24.95112551328647,363.89677855247584},{-24.95112551328647,343.89677855247584},{-24.95112551328647,323.89677855247584},{-24.95112551328647,303.89677855247584},{-24.95112551328647,283.8967785524758},{-24.95112551328647,263.8967785524758},{-24.95112551328647,243.89677855247578},{-24.95112551328647,223.89677855247578},{-24.95112551328647,203.89677855247578},{-24.95112551328647,183.89677855247578},{-24.95112551328647,163.89677855247578},{-24.95112551328647,143.89677855247578},{-24.95112551328647,123.89677855247578},{-24.95112551328647,103.89677855247578},{-24.95112551328647,83.89677855247578},{-24.95112551328647,63.89677855247578},{-4.95112551328647,63.89677855247578},{15.04887448671353,63.89677855247578}},color={0,0,127}));

  //
  // End Connect Statements for 21c80720
  //



  //
  // Begin Connect Statements for 87ad810f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_4deaf2ef.ports_bChiWat[1], cooInd_7f77fff9.port_a2)
    annotation (Line(points={{42.9773132721856,-20.131477841112996},{22.97731327218561,-20.131477841112996}},color={0,0,127}));
  connect(cooInd_7f77fff9.port_b2,TimeSerLoa_4deaf2ef.ports_aChiWat[1])
    annotation (Line(points={{44.12127312982315,-18.639400676708874},{64.12127312982315,-18.639400676708874}},color={0,0,127}));
  connect(pressure_source_87ad810f.ports[1], cooInd_7f77fff9.port_b2)
    annotation (Line(points={{13.54354195989255,-641.9437484852695},{-6.456458040107449,-641.9437484852695},{-6.456458040107449,-621.9437484852695},{-6.456458040107449,-601.9437484852695},{-6.456458040107449,-581.9437484852695},{-6.456458040107449,-561.9437484852695},{-6.456458040107449,-541.9437484852695},{-6.456458040107449,-521.9437484852695},{-6.456458040107449,-501.94374848526945},{-6.456458040107449,-481.94374848526945},{-6.456458040107449,-461.94374848526945},{-6.456458040107449,-441.94374848526945},{-6.456458040107449,-421.94374848526945},{-6.456458040107449,-401.94374848526945},{-6.456458040107449,-381.94374848526945},{-6.456458040107449,-361.94374848526945},{-6.456458040107449,-341.94374848526945},{-6.456458040107449,-321.94374848526945},{-6.456458040107449,-301.94374848526945},{-6.456458040107449,-281.94374848526945},{-6.456458040107449,-261.94374848526945},{-6.456458040107449,-241.94374848526945},{-6.456458040107449,-221.94374848526945},{-6.456458040107449,-201.94374848526957},{-6.456458040107449,-181.94374848526957},{-6.456458040107449,-161.94374848526957},{-6.456458040107449,-141.94374848526957},{-6.456458040107449,-121.94374848526957},{-6.456458040107449,-101.94374848526957},{-6.456458040107449,-81.94374848526957},{-6.456458040107449,-61.943748485269566},{-6.456458040107449,-41.943748485269566},{-6.456458040107449,-21.943748485269566},{13.54354195989255,-21.943748485269566}},color={0,0,127}));
  connect(TChiWatSet_87ad810f.y,cooInd_7f77fff9.TSetBuiSup)
    annotation (Line(points={{68.83654704205719,-634.0251661387358},{48.83654704205719,-634.0251661387358},{48.83654704205719,-614.0251661387358},{48.83654704205719,-594.0251661387358},{48.83654704205719,-574.0251661387358},{48.83654704205719,-554.0251661387358},{48.83654704205719,-534.0251661387358},{48.83654704205719,-514.0251661387358},{48.83654704205719,-494.0251661387358},{48.83654704205719,-474.0251661387358},{48.83654704205719,-454.0251661387358},{48.83654704205719,-434.0251661387358},{48.83654704205719,-414.0251661387358},{48.83654704205719,-394.0251661387358},{48.83654704205719,-374.0251661387358},{48.83654704205719,-354.0251661387358},{48.83654704205719,-334.0251661387358},{48.83654704205719,-314.0251661387358},{48.83654704205719,-294.0251661387358},{48.83654704205719,-274.0251661387358},{48.83654704205719,-254.0251661387358},{48.83654704205719,-234.0251661387358},{48.83654704205719,-214.0251661387358},{48.83654704205719,-194.0251661387358},{48.83654704205719,-174.0251661387358},{48.83654704205719,-154.0251661387358},{48.83654704205719,-134.0251661387358},{48.83654704205719,-114.02516613873581},{48.83654704205719,-94.02516613873581},{48.83654704205719,-74.02516613873581},{48.83654704205719,-54.02516613873581},{48.83654704205719,-34.02516613873581},{48.83654704205719,-14.025166138735813},{68.83654704205719,-14.025166138735813}},color={0,0,127}));

  //
  // End Connect Statements for 87ad810f
  //



  //
  // Begin Connect Statements for 67daf811
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[11],cooInd_7f77fff9.port_a1)
    annotation (Line(points={{-26.64771051972052,761.2387492408922},{-6.647710519720519,761.2387492408922},{-6.647710519720519,741.2387492408922},{-6.647710519720519,721.2387492408922},{-6.647710519720519,701.2387492408922},{-6.647710519720519,681.2387492408922},{-6.647710519720519,661.2387492408922},{-6.647710519720519,641.2387492408922},{-6.647710519720519,621.2387492408922},{-6.647710519720519,601.2387492408922},{-6.647710519720519,581.2387492408922},{-6.647710519720519,561.2387492408922},{-6.647710519720519,541.2387492408923},{-6.647710519720519,521.2387492408923},{-6.647710519720519,501.2387492408922},{-6.647710519720519,481.2387492408922},{-6.647710519720519,461.2387492408922},{-6.647710519720519,441.2387492408922},{-6.647710519720519,421.2387492408922},{-6.647710519720519,401.2387492408922},{-6.647710519720519,381.2387492408922},{-6.647710519720519,361.2387492408922},{-6.647710519720519,341.2387492408922},{-6.647710519720519,321.2387492408922},{-6.647710519720519,301.2387492408922},{-6.647710519720519,281.23874924089216},{-6.647710519720519,261.23874924089216},{-6.647710519720519,241.23874924089216},{-6.647710519720519,221.23874924089216},{-6.647710519720519,201.23874924089216},{-6.647710519720519,181.23874924089216},{-6.647710519720519,161.23874924089216},{-6.647710519720519,141.23874924089216},{-6.647710519720519,121.23874924089216},{-6.647710519720519,101.23874924089216},{-6.647710519720519,81.23874924089216},{-6.647710519720519,61.23874924089216},{-6.647710519720519,41.23874924089216},{-6.647710519720519,21.23874924089216},{-6.647710519720519,1.2387492408921617},{-6.647710519720519,-18.76125075910784},{13.352289480279481,-18.76125075910784}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[11],cooInd_7f77fff9.port_b1)
    annotation (Line(points={{-20.00100965078809,767.0542864112621},{-0.001009650788091676,767.0542864112621},{-0.001009650788091676,747.0542864112621},{-0.001009650788091676,727.0542864112621},{-0.001009650788091676,707.0542864112621},{-0.001009650788091676,687.0542864112621},{-0.001009650788091676,667.0542864112621},{-0.001009650788091676,647.0542864112621},{-0.001009650788091676,627.0542864112621},{-0.001009650788091676,607.0542864112621},{-0.001009650788091676,587.0542864112621},{-0.001009650788091676,567.0542864112621},{-0.001009650788091676,547.054286411262},{-0.001009650788091676,527.054286411262},{-0.001009650788091676,507.054286411262},{-0.001009650788091676,487.054286411262},{-0.001009650788091676,467.054286411262},{-0.001009650788091676,447.054286411262},{-0.001009650788091676,427.054286411262},{-0.001009650788091676,407.054286411262},{-0.001009650788091676,387.054286411262},{-0.001009650788091676,367.054286411262},{-0.001009650788091676,347.054286411262},{-0.001009650788091676,327.054286411262},{-0.001009650788091676,307.054286411262},{-0.001009650788091676,287.05428641126207},{-0.001009650788091676,267.05428641126207},{-0.001009650788091676,247.05428641126207},{-0.001009650788091676,227.05428641126207},{-0.001009650788091676,207.05428641126207},{-0.001009650788091676,187.05428641126207},{-0.001009650788091676,167.05428641126207},{-0.001009650788091676,147.05428641126207},{-0.001009650788091676,127.05428641126207},{-0.001009650788091676,107.05428641126207},{-0.001009650788091676,87.05428641126207},{-0.001009650788091676,67.05428641126207},{-0.001009650788091676,47.05428641126207},{-0.001009650788091676,27.05428641126207},{-0.001009650788091676,7.054286411262069},{-0.001009650788091676,-12.94571358873793},{19.99899034921191,-12.94571358873793}},color={0,0,127}));

  //
  // End Connect Statements for 67daf811
  //



  //
  // Begin Connect Statements for e77fbdf5
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_4deaf2ef.ports_bHeaWat[1], heaInd_b5e8a543.port_a2)
    annotation (Line(points={{69.4627287586884,-44.41887079506307},{69.4627287586884,-64.41887079506307},{49.4627287586884,-64.41887079506307},{29.462728758688385,-64.41887079506307}},color={0,0,127}));
  connect(heaInd_b5e8a543.port_b2,TimeSerLoa_4deaf2ef.ports_aHeaWat[1])
    annotation (Line(points={{21.834499006651825,-38.052855155563634},{41.83449900665181,-38.052855155563634},{41.83449900665181,-18.052855155563634},{61.83449900665181,-18.052855155563634}},color={0,0,127}));
  connect(pressure_source_e77fbdf5.ports[1], heaInd_b5e8a543.port_b2)
    annotation (Line(points={{-61.66385830347794,-674.2812437544653},{-41.66385830347794,-674.2812437544653},{-41.66385830347794,-654.2812437544653},{-41.66385830347794,-634.2812437544653},{-41.66385830347794,-614.2812437544653},{-41.66385830347794,-594.2812437544653},{-41.66385830347794,-574.2812437544653},{-41.66385830347794,-554.2812437544653},{-41.66385830347794,-534.2812437544653},{-41.66385830347794,-514.2812437544653},{-41.66385830347794,-494.2812437544653},{-41.66385830347794,-474.2812437544653},{-41.66385830347794,-454.2812437544653},{-41.66385830347794,-434.2812437544653},{-41.66385830347794,-414.2812437544653},{-41.66385830347794,-394.2812437544653},{-41.66385830347794,-374.2812437544653},{-41.66385830347794,-354.2812437544653},{-41.66385830347794,-334.2812437544653},{-41.66385830347794,-314.2812437544653},{-41.66385830347794,-294.2812437544653},{-41.66385830347794,-274.2812437544653},{-41.66385830347794,-254.28124375446532},{-41.66385830347794,-234.28124375446532},{-41.66385830347794,-214.28124375446532},{-41.66385830347794,-194.28124375446544},{-41.66385830347794,-174.28124375446544},{-41.66385830347794,-154.28124375446544},{-41.66385830347794,-134.28124375446544},{-41.66385830347794,-114.28124375446544},{-41.66385830347794,-94.28124375446544},{-41.66385830347794,-74.28124375446544},{-41.66385830347794,-54.281243754465436},{-21.663858303477937,-54.281243754465436},{-1.6638583034779373,-54.281243754465436},{18.336141696522063,-54.281243754465436}},color={0,0,127}));
  connect(THeaWatSet_e77fbdf5.y,heaInd_b5e8a543.TSetBuiSup)
    annotation (Line(points={{-24.617351086920237,-676.9426424409669},{-4.617351086920237,-676.9426424409669},{-4.617351086920237,-656.9426424409669},{-4.617351086920237,-636.9426424409669},{-4.617351086920237,-616.9426424409669},{-4.617351086920237,-596.9426424409669},{-4.617351086920237,-576.9426424409669},{-4.617351086920237,-556.9426424409669},{-4.617351086920237,-536.9426424409669},{-4.617351086920237,-516.9426424409669},{-4.617351086920237,-496.9426424409669},{-4.617351086920237,-476.9426424409669},{-4.617351086920237,-456.9426424409669},{-4.617351086920237,-436.9426424409669},{-4.617351086920237,-416.9426424409669},{-4.617351086920237,-396.9426424409669},{-4.617351086920237,-376.9426424409669},{-4.617351086920237,-356.9426424409669},{-4.617351086920237,-336.9426424409669},{-4.617351086920237,-316.9426424409669},{-4.617351086920237,-296.9426424409669},{-4.617351086920237,-276.9426424409669},{-4.617351086920237,-256.9426424409669},{-4.617351086920237,-236.9426424409669},{-4.617351086920237,-216.9426424409669},{-4.617351086920237,-196.9426424409669},{-4.617351086920237,-176.9426424409669},{-4.617351086920237,-156.9426424409669},{-4.617351086920237,-136.9426424409669},{-4.617351086920237,-116.94264244096689},{-4.617351086920237,-96.94264244096689},{-4.617351086920237,-76.94264244096689},{-4.617351086920237,-56.94264244096689},{15.382648913079763,-56.94264244096689}},color={0,0,127}));

  //
  // End Connect Statements for e77fbdf5
  //



  //
  // Begin Connect Statements for 9961c4c8
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[11],heaInd_b5e8a543.port_a1)
    annotation (Line(points={{-21.69535721561661,711.210347782298},{-21.69535721561661,691.210347782298},{-21.69535721561661,671.210347782298},{-21.69535721561661,651.210347782298},{-21.69535721561661,631.210347782298},{-21.69535721561661,611.210347782298},{-21.69535721561661,591.210347782298},{-21.69535721561661,571.210347782298},{-21.69535721561661,551.210347782298},{-21.69535721561661,531.210347782298},{-21.69535721561661,511.210347782298},{-21.69535721561661,491.210347782298},{-21.69535721561661,471.210347782298},{-21.69535721561661,451.210347782298},{-21.69535721561661,431.210347782298},{-21.69535721561661,411.210347782298},{-21.69535721561661,391.210347782298},{-21.69535721561661,371.210347782298},{-21.69535721561661,351.210347782298},{-21.69535721561661,331.210347782298},{-21.69535721561661,311.210347782298},{-21.69535721561661,291.21034778229796},{-21.69535721561661,271.21034778229796},{-21.69535721561661,251.21034778229796},{-21.69535721561661,231.21034778229796},{-21.69535721561661,211.21034778229796},{-21.69535721561661,191.21034778229796},{-21.69535721561661,171.21034778229796},{-21.69535721561661,151.21034778229796},{-21.69535721561661,131.21034778229796},{-21.69535721561661,111.21034778229796},{-21.69535721561661,91.21034778229796},{-21.69535721561661,71.21034778229796},{-21.69535721561661,51.21034778229796},{-21.69535721561661,31.21034778229796},{-21.69535721561661,11.210347782297958},{-21.69535721561661,-8.789652217702042},{-21.69535721561661,-28.78965221770204},{-21.69535721561661,-48.78965221770204},{-21.69535721561661,-68.78965221770204},{-1.6953572156166103,-68.78965221770204},{18.30464278438339,-68.78965221770204}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[11],heaInd_b5e8a543.port_b1)
    annotation (Line(points={{-21.601711242707438,713.4067424126321},{-21.601711242707438,693.4067424126321},{-21.601711242707438,673.4067424126321},{-21.601711242707438,653.4067424126321},{-21.601711242707438,633.4067424126321},{-21.601711242707438,613.4067424126321},{-21.601711242707438,593.4067424126321},{-21.601711242707438,573.4067424126321},{-21.601711242707438,553.4067424126321},{-21.601711242707438,533.4067424126321},{-21.601711242707438,513.4067424126321},{-21.601711242707438,493.40674241263207},{-21.601711242707438,473.40674241263207},{-21.601711242707438,453.40674241263207},{-21.601711242707438,433.40674241263207},{-21.601711242707438,413.40674241263207},{-21.601711242707438,393.40674241263207},{-21.601711242707438,373.40674241263207},{-21.601711242707438,353.40674241263207},{-21.601711242707438,333.40674241263207},{-21.601711242707438,313.40674241263207},{-21.601711242707438,293.40674241263207},{-21.601711242707438,273.40674241263207},{-21.601711242707438,253.40674241263207},{-21.601711242707438,233.40674241263207},{-21.601711242707438,213.40674241263207},{-21.601711242707438,193.40674241263207},{-21.601711242707438,173.40674241263207},{-21.601711242707438,153.40674241263207},{-21.601711242707438,133.40674241263207},{-21.601711242707438,113.40674241263207},{-21.601711242707438,93.40674241263207},{-21.601711242707438,73.40674241263207},{-21.601711242707438,53.40674241263207},{-21.601711242707438,33.40674241263207},{-21.601711242707438,13.40674241263207},{-21.601711242707438,-6.59325758736793},{-21.601711242707438,-26.59325758736793},{-21.601711242707438,-46.59325758736793},{-21.601711242707438,-66.59325758736793},{-1.601711242707438,-66.59325758736793},{18.398288757292562,-66.59325758736793}},color={0,0,127}));

  //
  // End Connect Statements for 9961c4c8
  //



  //
  // Begin Connect Statements for 3a58dac6
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_3acc8a8e.ports_bChiWat[1], cooInd_2fa0b7df.port_a2)
    annotation (Line(points={{45.15642291739255,-95.15280457457789},{25.156422917392533,-95.15280457457789}},color={0,0,127}));
  connect(cooInd_2fa0b7df.port_b2,TimeSerLoa_3acc8a8e.ports_aChiWat[1])
    annotation (Line(points={{46.39122706096748,-99.51057048974621},{66.39122706096748,-99.51057048974621}},color={0,0,127}));
  connect(pressure_source_3a58dac6.ports[1], cooInd_2fa0b7df.port_b2)
    annotation (Line(points={{27.217455855836477,-685.0193234623528},{7.2174558558364765,-685.0193234623528},{7.2174558558364765,-665.0193234623528},{7.2174558558364765,-645.0193234623528},{7.2174558558364765,-625.0193234623528},{7.2174558558364765,-605.0193234623528},{7.2174558558364765,-585.0193234623528},{7.2174558558364765,-565.0193234623528},{7.2174558558364765,-545.0193234623528},{7.2174558558364765,-525.0193234623528},{7.2174558558364765,-505.01932346235276},{7.2174558558364765,-485.01932346235276},{7.2174558558364765,-465.01932346235276},{7.2174558558364765,-445.01932346235276},{7.2174558558364765,-425.01932346235276},{7.2174558558364765,-405.01932346235276},{7.2174558558364765,-385.01932346235276},{7.2174558558364765,-365.01932346235276},{7.2174558558364765,-345.01932346235276},{7.2174558558364765,-325.01932346235276},{7.2174558558364765,-305.01932346235276},{7.2174558558364765,-285.01932346235276},{7.2174558558364765,-265.01932346235276},{7.2174558558364765,-245.01932346235276},{7.2174558558364765,-225.01932346235276},{7.2174558558364765,-205.01932346235276},{7.2174558558364765,-185.01932346235276},{7.2174558558364765,-165.01932346235276},{7.2174558558364765,-145.01932346235276},{7.2174558558364765,-125.01932346235276},{7.2174558558364765,-105.01932346235276},{27.217455855836477,-105.01932346235276}},color={0,0,127}));
  connect(TChiWatSet_3a58dac6.y,cooInd_2fa0b7df.TSetBuiSup)
    annotation (Line(points={{51.04442388318688,-675.6761415543781},{31.044423883186866,-675.6761415543781},{31.044423883186866,-655.6761415543781},{31.044423883186866,-635.6761415543781},{31.044423883186866,-615.6761415543781},{31.044423883186866,-595.6761415543781},{31.044423883186866,-575.6761415543781},{31.044423883186866,-555.6761415543781},{31.044423883186866,-535.6761415543781},{31.044423883186866,-515.6761415543781},{31.044423883186866,-495.6761415543781},{31.044423883186866,-475.6761415543781},{31.044423883186866,-455.6761415543781},{31.044423883186866,-435.6761415543781},{31.044423883186866,-415.6761415543781},{31.044423883186866,-395.6761415543781},{31.044423883186866,-375.6761415543781},{31.044423883186866,-355.6761415543781},{31.044423883186866,-335.6761415543781},{31.044423883186866,-315.6761415543781},{31.044423883186866,-295.6761415543781},{31.044423883186866,-275.6761415543781},{31.044423883186866,-255.6761415543781},{31.044423883186866,-235.6761415543781},{31.044423883186866,-215.6761415543781},{31.044423883186866,-195.6761415543781},{31.044423883186866,-175.6761415543781},{31.044423883186866,-155.6761415543781},{31.044423883186866,-135.6761415543781},{31.044423883186866,-115.67614155437809},{31.044423883186866,-95.67614155437809},{51.04442388318688,-95.67614155437809}},color={0,0,127}));

  //
  // End Connect Statements for 3a58dac6
  //



  //
  // Begin Connect Statements for af11d010
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[12],cooInd_2fa0b7df.port_a1)
    annotation (Line(points={{-20.93441272313791,763.3410086815442},{-0.9344127231379105,763.3410086815442},{-0.9344127231379105,743.3410086815442},{-0.9344127231379105,723.3410086815442},{-0.9344127231379105,703.3410086815442},{-0.9344127231379105,683.3410086815442},{-0.9344127231379105,663.3410086815442},{-0.9344127231379105,643.3410086815442},{-0.9344127231379105,623.3410086815442},{-0.9344127231379105,603.3410086815442},{-0.9344127231379105,583.3410086815442},{-0.9344127231379105,563.3410086815442},{-0.9344127231379105,543.3410086815442},{-0.9344127231379105,523.3410086815442},{-0.9344127231379105,503.34100868154417},{-0.9344127231379105,483.34100868154417},{-0.9344127231379105,463.34100868154417},{-0.9344127231379105,443.34100868154417},{-0.9344127231379105,423.34100868154417},{-0.9344127231379105,403.34100868154417},{-0.9344127231379105,383.34100868154417},{-0.9344127231379105,363.34100868154417},{-0.9344127231379105,343.34100868154417},{-0.9344127231379105,323.34100868154417},{-0.9344127231379105,303.34100868154417},{-0.9344127231379105,283.34100868154417},{-0.9344127231379105,263.34100868154417},{-0.9344127231379105,243.34100868154417},{-0.9344127231379105,223.34100868154417},{-0.9344127231379105,203.34100868154417},{-0.9344127231379105,183.34100868154417},{-0.9344127231379105,163.34100868154417},{-0.9344127231379105,143.34100868154417},{-0.9344127231379105,123.34100868154417},{-0.9344127231379105,103.34100868154417},{-0.9344127231379105,83.34100868154417},{-0.9344127231379105,63.34100868154417},{-0.9344127231379105,43.34100868154417},{-0.9344127231379105,23.341008681544167},{-0.9344127231379105,3.3410086815441673},{-0.9344127231379105,-16.658991318455833},{-0.9344127231379105,-36.65899131845583},{-0.9344127231379105,-56.65899131845583},{-0.9344127231379105,-76.65899131845583},{-0.9344127231379105,-96.65899131845583},{19.06558727686209,-96.65899131845583}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[12],cooInd_2fa0b7df.port_b1)
    annotation (Line(points={{-26.325041271440675,767.0092824172474},{-6.325041271440668,767.0092824172474},{-6.325041271440668,747.0092824172474},{-6.325041271440668,727.0092824172474},{-6.325041271440668,707.0092824172474},{-6.325041271440668,687.0092824172474},{-6.325041271440668,667.0092824172474},{-6.325041271440668,647.0092824172474},{-6.325041271440668,627.0092824172474},{-6.325041271440668,607.0092824172474},{-6.325041271440668,587.0092824172474},{-6.325041271440668,567.0092824172474},{-6.325041271440668,547.0092824172474},{-6.325041271440668,527.0092824172474},{-6.325041271440668,507.0092824172474},{-6.325041271440668,487.0092824172474},{-6.325041271440668,467.0092824172474},{-6.325041271440668,447.0092824172474},{-6.325041271440668,427.0092824172474},{-6.325041271440668,407.0092824172474},{-6.325041271440668,387.0092824172474},{-6.325041271440668,367.0092824172474},{-6.325041271440668,347.0092824172474},{-6.325041271440668,327.0092824172474},{-6.325041271440668,307.0092824172474},{-6.325041271440668,287.0092824172474},{-6.325041271440668,267.0092824172474},{-6.325041271440668,247.0092824172474},{-6.325041271440668,227.0092824172474},{-6.325041271440668,207.0092824172474},{-6.325041271440668,187.0092824172474},{-6.325041271440668,167.0092824172474},{-6.325041271440668,147.0092824172474},{-6.325041271440668,127.00928241724739},{-6.325041271440668,107.00928241724739},{-6.325041271440668,87.00928241724739},{-6.325041271440668,67.00928241724739},{-6.325041271440668,47.00928241724739},{-6.325041271440668,27.00928241724739},{-6.325041271440668,7.009282417247391},{-6.325041271440668,-12.990717582752609},{-6.325041271440668,-32.99071758275261},{-6.325041271440668,-52.99071758275261},{-6.325041271440668,-72.99071758275261},{-6.325041271440668,-92.99071758275261},{13.674958728559332,-92.99071758275261}},color={0,0,127}));

  //
  // End Connect Statements for af11d010
  //



  //
  // Begin Connect Statements for ad9c3b92
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_3acc8a8e.ports_bHeaWat[1], heaInd_c1bff424.port_a2)
    annotation (Line(points={{64.24455468292726,-113.55189298375467},{64.24455468292726,-133.55189298375467},{44.24455468292726,-133.55189298375467},{24.24455468292726,-133.55189298375467}},color={0,0,127}));
  connect(heaInd_c1bff424.port_b2,TimeSerLoa_3acc8a8e.ports_aHeaWat[1])
    annotation (Line(points={{28.740457966249124,-127.95065546416083},{48.740457966249124,-127.95065546416083},{48.740457966249124,-107.95065546416083},{68.74045796624912,-107.95065546416083}},color={0,0,127}));
  connect(pressure_source_ad9c3b92.ports[1], heaInd_c1bff424.port_b2)
    annotation (Line(points={{-65.07563883701641,-714.1711199535116},{-45.075638837016406,-714.1711199535116},{-45.075638837016406,-694.1711199535116},{-45.075638837016406,-674.1711199535116},{-45.075638837016406,-654.1711199535116},{-45.075638837016406,-634.1711199535116},{-45.075638837016406,-614.1711199535116},{-45.075638837016406,-594.1711199535116},{-45.075638837016406,-574.1711199535116},{-45.075638837016406,-554.1711199535116},{-45.075638837016406,-534.1711199535116},{-45.075638837016406,-514.1711199535116},{-45.075638837016406,-494.1711199535116},{-45.075638837016406,-474.1711199535116},{-45.075638837016406,-454.1711199535116},{-45.075638837016406,-434.1711199535116},{-45.075638837016406,-414.1711199535116},{-45.075638837016406,-394.1711199535116},{-45.075638837016406,-374.1711199535116},{-45.075638837016406,-354.1711199535116},{-45.075638837016406,-334.1711199535116},{-45.075638837016406,-314.1711199535116},{-45.075638837016406,-294.1711199535116},{-45.075638837016406,-274.1711199535116},{-45.075638837016406,-254.1711199535116},{-45.075638837016406,-234.1711199535116},{-45.075638837016406,-214.1711199535116},{-45.075638837016406,-194.1711199535116},{-45.075638837016406,-174.1711199535116},{-45.075638837016406,-154.1711199535116},{-45.075638837016406,-134.1711199535116},{-25.075638837016413,-134.1711199535116},{-5.075638837016413,-134.1711199535116},{14.924361162983587,-134.1711199535116}},color={0,0,127}));
  connect(THeaWatSet_ad9c3b92.y,heaInd_c1bff424.TSetBuiSup)
    annotation (Line(points={{-29.904095533659216,-719.5329221851646},{-9.904095533659216,-719.5329221851646},{-9.904095533659216,-699.5329221851646},{-9.904095533659216,-679.5329221851646},{-9.904095533659216,-659.5329221851646},{-9.904095533659216,-639.5329221851646},{-9.904095533659216,-619.5329221851646},{-9.904095533659216,-599.5329221851646},{-9.904095533659216,-579.5329221851646},{-9.904095533659216,-559.5329221851646},{-9.904095533659216,-539.5329221851646},{-9.904095533659216,-519.5329221851646},{-9.904095533659216,-499.5329221851646},{-9.904095533659216,-479.5329221851646},{-9.904095533659216,-459.5329221851646},{-9.904095533659216,-439.5329221851646},{-9.904095533659216,-419.5329221851646},{-9.904095533659216,-399.5329221851646},{-9.904095533659216,-379.5329221851646},{-9.904095533659216,-359.5329221851646},{-9.904095533659216,-339.5329221851646},{-9.904095533659216,-319.5329221851646},{-9.904095533659216,-299.5329221851646},{-9.904095533659216,-279.5329221851646},{-9.904095533659216,-259.5329221851646},{-9.904095533659216,-239.53292218516458},{-9.904095533659216,-219.53292218516458},{-9.904095533659216,-199.5329221851647},{-9.904095533659216,-179.5329221851647},{-9.904095533659216,-159.5329221851647},{-9.904095533659216,-139.5329221851647},{10.095904466340784,-139.5329221851647}},color={0,0,127}));

  //
  // End Connect Statements for ad9c3b92
  //



  //
  // Begin Connect Statements for c7073b9b
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[12],heaInd_c1bff424.port_a1)
    annotation (Line(points={{-14.445875392637348,715.2211242912394},{-14.445875392637348,695.2211242912394},{-14.445875392637348,675.2211242912394},{-14.445875392637348,655.2211242912394},{-14.445875392637348,635.2211242912394},{-14.445875392637348,615.2211242912394},{-14.445875392637348,595.2211242912394},{-14.445875392637348,575.2211242912394},{-14.445875392637348,555.2211242912394},{-14.445875392637348,535.2211242912394},{-14.445875392637348,515.2211242912394},{-14.445875392637348,495.22112429123945},{-14.445875392637348,475.22112429123945},{-14.445875392637348,455.22112429123945},{-14.445875392637348,435.22112429123945},{-14.445875392637348,415.22112429123945},{-14.445875392637348,395.22112429123945},{-14.445875392637348,375.22112429123945},{-14.445875392637348,355.22112429123945},{-14.445875392637348,335.22112429123945},{-14.445875392637348,315.22112429123945},{-14.445875392637348,295.22112429123945},{-14.445875392637348,275.22112429123945},{-14.445875392637348,255.22112429123945},{-14.445875392637348,235.22112429123945},{-14.445875392637348,215.22112429123945},{-14.445875392637348,195.22112429123945},{-14.445875392637348,175.22112429123945},{-14.445875392637348,155.22112429123945},{-14.445875392637348,135.22112429123945},{-14.445875392637348,115.22112429123945},{-14.445875392637348,95.22112429123945},{-14.445875392637348,75.22112429123945},{-14.445875392637348,55.22112429123945},{-14.445875392637348,35.22112429123945},{-14.445875392637348,15.221124291239448},{-14.445875392637348,-4.778875708760552},{-14.445875392637348,-24.778875708760552},{-14.445875392637348,-44.77887570876055},{-14.445875392637348,-64.77887570876055},{-14.445875392637348,-84.77887570876055},{-14.445875392637348,-104.77887570876055},{-14.445875392637348,-124.77887570876055},{-14.445875392637348,-144.77887570876055},{5.5541246073626525,-144.77887570876055},{25.554124607362652,-144.77887570876055}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[12],heaInd_c1bff424.port_b1)
    annotation (Line(points={{-12.600873277903517,727.233901029246},{-12.600873277903517,707.233901029246},{-12.600873277903517,687.233901029246},{-12.600873277903517,667.233901029246},{-12.600873277903517,647.233901029246},{-12.600873277903517,627.233901029246},{-12.600873277903517,607.233901029246},{-12.600873277903517,587.233901029246},{-12.600873277903517,567.233901029246},{-12.600873277903517,547.233901029246},{-12.600873277903517,527.233901029246},{-12.600873277903517,507.23390102924606},{-12.600873277903517,487.23390102924606},{-12.600873277903517,467.23390102924606},{-12.600873277903517,447.23390102924606},{-12.600873277903517,427.23390102924606},{-12.600873277903517,407.23390102924606},{-12.600873277903517,387.23390102924606},{-12.600873277903517,367.23390102924606},{-12.600873277903517,347.23390102924606},{-12.600873277903517,327.23390102924606},{-12.600873277903517,307.23390102924606},{-12.600873277903517,287.233901029246},{-12.600873277903517,267.233901029246},{-12.600873277903517,247.233901029246},{-12.600873277903517,227.233901029246},{-12.600873277903517,207.233901029246},{-12.600873277903517,187.233901029246},{-12.600873277903517,167.233901029246},{-12.600873277903517,147.233901029246},{-12.600873277903517,127.233901029246},{-12.600873277903517,107.233901029246},{-12.600873277903517,87.233901029246},{-12.600873277903517,67.233901029246},{-12.600873277903517,47.233901029246},{-12.600873277903517,27.233901029246},{-12.600873277903517,7.233901029245999},{-12.600873277903517,-12.766098970754001},{-12.600873277903517,-32.766098970754},{-12.600873277903517,-52.766098970754},{-12.600873277903517,-72.766098970754},{-12.600873277903517,-92.766098970754},{-12.600873277903517,-112.766098970754},{-12.600873277903517,-132.766098970754},{7.399126722096483,-132.766098970754},{27.399126722096483,-132.766098970754}},color={0,0,127}));

  //
  // End Connect Statements for c7073b9b
  //



  //
  // Begin Connect Statements for 59ecdc88
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_90fce148.ports_bChiWat[1], cooInd_b32df680.port_a2)
    annotation (Line(points={{61.575398071747344,-195.489901108867},{61.575398071747344,-215.48990110886712},{41.575398071747344,-215.48990110886712},{21.575398071747344,-215.48990110886712}},color={0,0,127}));
  connect(cooInd_b32df680.port_b2,TimeSerLoa_90fce148.ports_aChiWat[1])
    annotation (Line(points={{27.27003808554339,-204.88586170534916},{47.270038085543376,-204.88586170534916},{47.270038085543376,-184.88586170534916},{67.27003808554338,-184.88586170534916}},color={0,0,127}));
  connect(pressure_source_59ecdc88.ports[1], cooInd_b32df680.port_b2)
    annotation (Line(points={{22.80389473542236,-710.54177242833},{2.803894735422361,-710.54177242833},{2.803894735422361,-690.54177242833},{2.803894735422361,-670.54177242833},{2.803894735422361,-650.54177242833},{2.803894735422361,-630.54177242833},{2.803894735422361,-610.54177242833},{2.803894735422361,-590.54177242833},{2.803894735422361,-570.54177242833},{2.803894735422361,-550.54177242833},{2.803894735422361,-530.54177242833},{2.803894735422361,-510.54177242833},{2.803894735422361,-490.54177242833},{2.803894735422361,-470.54177242833},{2.803894735422361,-450.54177242833},{2.803894735422361,-430.54177242833},{2.803894735422361,-410.54177242833},{2.803894735422361,-390.54177242833},{2.803894735422361,-370.54177242833},{2.803894735422361,-350.54177242833},{2.803894735422361,-330.54177242833},{2.803894735422361,-310.54177242833},{2.803894735422361,-290.54177242833},{2.803894735422361,-270.54177242833},{2.803894735422361,-250.54177242832998},{2.803894735422361,-230.54177242832998},{2.803894735422361,-210.54177242832998},{22.80389473542236,-210.54177242832998}},color={0,0,127}));
  connect(TChiWatSet_59ecdc88.y,cooInd_b32df680.TSetBuiSup)
    annotation (Line(points={{57.28025410947254,-717.5961311103265},{37.28025410947254,-717.5961311103265},{37.28025410947254,-697.5961311103265},{37.28025410947254,-677.5961311103265},{37.28025410947254,-657.5961311103265},{37.28025410947254,-637.5961311103265},{37.28025410947254,-617.5961311103265},{37.28025410947254,-597.5961311103265},{37.28025410947254,-577.5961311103265},{37.28025410947254,-557.5961311103265},{37.28025410947254,-537.5961311103265},{37.28025410947254,-517.5961311103265},{37.28025410947254,-497.5961311103265},{37.28025410947254,-477.5961311103265},{37.28025410947254,-457.5961311103265},{37.28025410947254,-437.5961311103265},{37.28025410947254,-417.5961311103265},{37.28025410947254,-397.5961311103265},{37.28025410947254,-377.5961311103265},{37.28025410947254,-357.5961311103265},{37.28025410947254,-337.5961311103265},{37.28025410947254,-317.5961311103265},{37.28025410947254,-297.5961311103265},{37.28025410947254,-277.5961311103265},{37.28025410947254,-257.5961311103265},{37.28025410947254,-237.5961311103265},{37.28025410947254,-217.5961311103265},{37.28025410947254,-197.5961311103265},{37.28025410947254,-177.5961311103265},{57.28025410947254,-177.5961311103265}},color={0,0,127}));

  //
  // End Connect Statements for 59ecdc88
  //



  //
  // Begin Connect Statements for a73a5cdd
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_a752939f.ports_bCon[13],cooInd_b32df680.port_a1)
    annotation (Line(points={{-12.049261603987105,751.9053061648108},{7.950738396012895,751.9053061648108},{7.950738396012895,731.9053061648108},{7.950738396012895,711.9053061648108},{7.950738396012895,691.9053061648108},{7.950738396012895,671.9053061648108},{7.950738396012895,651.9053061648108},{7.950738396012895,631.9053061648108},{7.950738396012895,611.9053061648108},{7.950738396012895,591.9053061648108},{7.950738396012895,571.9053061648108},{7.950738396012895,551.9053061648108},{7.950738396012895,531.9053061648108},{7.950738396012895,511.90530616481084},{7.950738396012895,491.90530616481084},{7.950738396012895,471.90530616481084},{7.950738396012895,451.90530616481084},{7.950738396012895,431.90530616481084},{7.950738396012895,411.90530616481084},{7.950738396012895,391.90530616481084},{7.950738396012895,371.90530616481084},{7.950738396012895,351.90530616481084},{7.950738396012895,331.90530616481084},{7.950738396012895,311.90530616481084},{7.950738396012895,291.9053061648108},{7.950738396012895,271.9053061648108},{7.950738396012895,251.90530616481078},{7.950738396012895,231.90530616481078},{7.950738396012895,211.90530616481078},{7.950738396012895,191.90530616481078},{7.950738396012895,171.90530616481078},{7.950738396012895,151.90530616481078},{7.950738396012895,131.90530616481078},{7.950738396012895,111.90530616481078},{7.950738396012895,91.90530616481078},{7.950738396012895,71.90530616481078},{7.950738396012895,51.90530616481078},{7.950738396012895,31.90530616481078},{7.950738396012895,11.905306164810781},{7.950738396012895,-8.094693835189219},{7.950738396012895,-28.09469383518922},{7.950738396012895,-48.09469383518922},{7.950738396012895,-68.09469383518922},{7.950738396012895,-88.09469383518922},{7.950738396012895,-108.09469383518922},{7.950738396012895,-128.09469383518922},{7.950738396012895,-148.09469383518922},{7.950738396012895,-168.09469383518922},{7.950738396012895,-188.09469383518922},{7.950738396012895,-208.09469383518922},{7.950738396012895,-228.09469383518922},{27.950738396012895,-228.09469383518922}},color={0,0,127}));
  connect(disNet_a752939f.ports_aCon[13],cooInd_b32df680.port_b1)
    annotation (Line(points={{-23.453917269511848,762.5402273419468},{-3.453917269511848,762.5402273419468},{-3.453917269511848,742.5402273419468},{-3.453917269511848,722.5402273419468},{-3.453917269511848,702.5402273419468},{-3.453917269511848,682.5402273419468},{-3.453917269511848,662.5402273419468},{-3.453917269511848,642.5402273419468},{-3.453917269511848,622.5402273419468},{-3.453917269511848,602.5402273419468},{-3.453917269511848,582.5402273419468},{-3.453917269511848,562.5402273419468},{-3.453917269511848,542.5402273419468},{-3.453917269511848,522.5402273419468},{-3.453917269511848,502.5402273419468},{-3.453917269511848,482.5402273419468},{-3.453917269511848,462.5402273419468},{-3.453917269511848,442.5402273419468},{-3.453917269511848,422.5402273419468},{-3.453917269511848,402.5402273419468},{-3.453917269511848,382.5402273419468},{-3.453917269511848,362.5402273419468},{-3.453917269511848,342.5402273419468},{-3.453917269511848,322.5402273419468},{-3.453917269511848,302.5402273419468},{-3.453917269511848,282.5402273419468},{-3.453917269511848,262.5402273419468},{-3.453917269511848,242.54022734194677},{-3.453917269511848,222.54022734194677},{-3.453917269511848,202.54022734194677},{-3.453917269511848,182.54022734194677},{-3.453917269511848,162.54022734194677},{-3.453917269511848,142.54022734194677},{-3.453917269511848,122.54022734194677},{-3.453917269511848,102.54022734194677},{-3.453917269511848,82.54022734194677},{-3.453917269511848,62.540227341946775},{-3.453917269511848,42.540227341946775},{-3.453917269511848,22.540227341946775},{-3.453917269511848,2.5402273419467747},{-3.453917269511848,-17.459772658053225},{-3.453917269511848,-37.459772658053225},{-3.453917269511848,-57.459772658053225},{-3.453917269511848,-77.45977265805323},{-3.453917269511848,-97.45977265805323},{-3.453917269511848,-117.45977265805323},{-3.453917269511848,-137.45977265805323},{-3.453917269511848,-157.45977265805323},{-3.453917269511848,-177.45977265805323},{-3.453917269511848,-197.45977265805323},{-3.453917269511848,-217.45977265805323},{16.546082730488152,-217.45977265805323}},color={0,0,127}));

  //
  // End Connect Statements for a73a5cdd
  //



  //
  // Begin Connect Statements for b9bbe8b5
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_90fce148.ports_bHeaWat[1], heaInd_649c2ac7.port_a2)
    annotation (Line(points={{42.286763224675184,-185.0449558044976},{22.286763224675184,-185.0449558044976}},color={0,0,127}));
  connect(heaInd_649c2ac7.port_b2,TimeSerLoa_90fce148.ports_aHeaWat[1])
    annotation (Line(points={{42.441701371207614,-184.80289361910764},{62.441701371207614,-184.80289361910764}},color={0,0,127}));
  connect(pressure_source_b9bbe8b5.ports[1], heaInd_649c2ac7.port_b2)
    annotation (Line(points={{-55.149833317483356,-752.4014812120724},{-35.149833317483356,-752.4014812120724},{-35.149833317483356,-732.4014812120724},{-35.149833317483356,-712.4014812120724},{-35.149833317483356,-692.4014812120724},{-35.149833317483356,-672.4014812120724},{-35.149833317483356,-652.4014812120724},{-35.149833317483356,-632.4014812120724},{-35.149833317483356,-612.4014812120724},{-35.149833317483356,-592.4014812120724},{-35.149833317483356,-572.4014812120724},{-35.149833317483356,-552.4014812120724},{-35.149833317483356,-532.4014812120724},{-35.149833317483356,-512.4014812120724},{-35.149833317483356,-492.40148121207244},{-35.149833317483356,-472.40148121207244},{-35.149833317483356,-452.40148121207244},{-35.149833317483356,-432.40148121207244},{-35.149833317483356,-412.40148121207244},{-35.149833317483356,-392.40148121207244},{-35.149833317483356,-372.40148121207244},{-35.149833317483356,-352.40148121207244},{-35.149833317483356,-332.40148121207244},{-35.149833317483356,-312.40148121207244},{-35.149833317483356,-292.40148121207244},{-35.149833317483356,-272.40148121207244},{-35.149833317483356,-252.40148121207244},{-35.149833317483356,-232.40148121207244},{-35.149833317483356,-212.40148121207244},{-35.149833317483356,-192.40148121207244},{-35.149833317483356,-172.40148121207244},{-15.149833317483356,-172.40148121207244},{4.850166682516644,-172.40148121207244},{24.850166682516644,-172.40148121207244}},color={0,0,127}));
  connect(THeaWatSet_b9bbe8b5.y,heaInd_649c2ac7.TSetBuiSup)
    annotation (Line(points={{-29.37860846092724,-752.371118704229},{-9.37860846092724,-752.371118704229},{-9.37860846092724,-732.371118704229},{-9.37860846092724,-712.371118704229},{-9.37860846092724,-692.371118704229},{-9.37860846092724,-672.371118704229},{-9.37860846092724,-652.371118704229},{-9.37860846092724,-632.371118704229},{-9.37860846092724,-612.371118704229},{-9.37860846092724,-592.371118704229},{-9.37860846092724,-572.371118704229},{-9.37860846092724,-552.371118704229},{-9.37860846092724,-532.371118704229},{-9.37860846092724,-512.371118704229},{-9.37860846092724,-492.37111870422905},{-9.37860846092724,-472.37111870422905},{-9.37860846092724,-452.37111870422905},{-9.37860846092724,-432.37111870422905},{-9.37860846092724,-412.37111870422905},{-9.37860846092724,-392.37111870422905},{-9.37860846092724,-372.37111870422905},{-9.37860846092724,-352.37111870422905},{-9.37860846092724,-332.37111870422905},{-9.37860846092724,-312.37111870422905},{-9.37860846092724,-292.37111870422905},{-9.37860846092724,-272.37111870422905},{-9.37860846092724,-252.37111870422905},{-9.37860846092724,-232.37111870422905},{-9.37860846092724,-212.37111870422916},{-9.37860846092724,-192.37111870422916},{-9.37860846092724,-172.37111870422916},{10.62139153907276,-172.37111870422916}},color={0,0,127}));

  //
  // End Connect Statements for b9bbe8b5
  //



  //
  // Begin Connect Statements for d1d063dc
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_2feea5e7.ports_bCon[13],heaInd_649c2ac7.port_a1)
    annotation (Line(points={{-21.50739023301871,721.4385196128212},{-21.50739023301871,701.4385196128212},{-21.50739023301871,681.4385196128212},{-21.50739023301871,661.4385196128212},{-21.50739023301871,641.4385196128212},{-21.50739023301871,621.4385196128212},{-21.50739023301871,601.4385196128212},{-21.50739023301871,581.4385196128212},{-21.50739023301871,561.4385196128212},{-21.50739023301871,541.4385196128212},{-21.50739023301871,521.4385196128212},{-21.50739023301871,501.4385196128212},{-21.50739023301871,481.4385196128212},{-21.50739023301871,461.4385196128212},{-21.50739023301871,441.4385196128212},{-21.50739023301871,421.4385196128212},{-21.50739023301871,401.4385196128212},{-21.50739023301871,381.4385196128212},{-21.50739023301871,361.4385196128212},{-21.50739023301871,341.4385196128212},{-21.50739023301871,321.4385196128212},{-21.50739023301871,301.4385196128212},{-21.50739023301871,281.4385196128212},{-21.50739023301871,261.4385196128212},{-21.50739023301871,241.4385196128212},{-21.50739023301871,221.4385196128212},{-21.50739023301871,201.4385196128212},{-21.50739023301871,181.4385196128212},{-21.50739023301871,161.4385196128212},{-21.50739023301871,141.4385196128212},{-21.50739023301871,121.43851961282121},{-21.50739023301871,101.43851961282121},{-21.50739023301871,81.43851961282121},{-21.50739023301871,61.43851961282121},{-21.50739023301871,41.43851961282121},{-21.50739023301871,21.43851961282121},{-21.50739023301871,1.43851961282121},{-21.50739023301871,-18.56148038717879},{-21.50739023301871,-38.56148038717879},{-21.50739023301871,-58.56148038717879},{-21.50739023301871,-78.56148038717879},{-21.50739023301871,-98.56148038717879},{-21.50739023301871,-118.56148038717879},{-21.50739023301871,-138.5614803871788},{-21.50739023301871,-158.5614803871788},{-21.50739023301871,-178.5614803871788},{-1.507390233018711,-178.5614803871788},{18.49260976698129,-178.5614803871788}},color={0,0,127}));
  connect(disNet_2feea5e7.ports_aCon[13],heaInd_649c2ac7.port_b1)
    annotation (Line(points={{-27.24347071081973,725.7174711756271},{-27.24347071081973,705.7174711756271},{-27.24347071081973,685.7174711756271},{-27.24347071081973,665.7174711756271},{-27.24347071081973,645.7174711756271},{-27.24347071081973,625.7174711756271},{-27.24347071081973,605.7174711756271},{-27.24347071081973,585.7174711756271},{-27.24347071081973,565.7174711756271},{-27.24347071081973,545.7174711756271},{-27.24347071081973,525.7174711756271},{-27.24347071081973,505.7174711756271},{-27.24347071081973,485.7174711756271},{-27.24347071081973,465.7174711756271},{-27.24347071081973,445.7174711756271},{-27.24347071081973,425.7174711756271},{-27.24347071081973,405.7174711756271},{-27.24347071081973,385.7174711756271},{-27.24347071081973,365.7174711756271},{-27.24347071081973,345.7174711756271},{-27.24347071081973,325.7174711756271},{-27.24347071081973,305.7174711756271},{-27.24347071081973,285.7174711756271},{-27.24347071081973,265.7174711756271},{-27.24347071081973,245.7174711756271},{-27.24347071081973,225.7174711756271},{-27.24347071081973,205.7174711756271},{-27.24347071081973,185.7174711756271},{-27.24347071081973,165.7174711756271},{-27.24347071081973,145.7174711756271},{-27.24347071081973,125.71747117562711},{-27.24347071081973,105.71747117562711},{-27.24347071081973,85.71747117562711},{-27.24347071081973,65.71747117562711},{-27.24347071081973,45.71747117562711},{-27.24347071081973,25.71747117562711},{-27.24347071081973,5.717471175627111},{-27.24347071081973,-14.28252882437289},{-27.24347071081973,-34.28252882437289},{-27.24347071081973,-54.28252882437289},{-27.24347071081973,-74.28252882437289},{-27.24347071081973,-94.28252882437289},{-27.24347071081973,-114.28252882437289},{-27.24347071081973,-134.2825288243729},{-27.24347071081973,-154.2825288243729},{-27.24347071081973,-174.2825288243729},{-7.243470710819736,-174.2825288243729},{12.756529289180264,-174.2825288243729}},color={0,0,127}));

  //
  // End Connect Statements for d1d063dc
  //




annotation(
  experiment(
    StopTime=86400,
    Interval=3600,
    Tolerance=1e-06),
  Diagram(
    coordinateSystem(
      preserveAspectRatio=false,
      extent={{-90.0,-810.0},{90.0,810.0}})),
  Documentation(
    revisions="<html>
 <li>
 May 10, 2020: Hagar Elarga<br/>
Updated implementation to handle template needed for GeoJSON to Modelica.
</li>
</html>"));
end DistrictEnergySystem;