within baseline_demo.Districts;
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
  // Begin Model Instance for disNet_c4e29af7
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_c4e29af7=13;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_c4e29af7=sum({
    cooInd_5a3d0cc9.mDis_flow_nominal,
  cooInd_b433d2ec.mDis_flow_nominal,
  cooInd_71df9072.mDis_flow_nominal,
  cooInd_e21a2366.mDis_flow_nominal,
  cooInd_dbcdcad2.mDis_flow_nominal,
  cooInd_810d4a17.mDis_flow_nominal,
  cooInd_1b3259f7.mDis_flow_nominal,
  cooInd_8ecb3fa6.mDis_flow_nominal,
  cooInd_7511120a.mDis_flow_nominal,
  cooInd_08deacc6.mDis_flow_nominal,
  cooInd_f3301ead.mDis_flow_nominal,
  cooInd_0c0ee305.mDis_flow_nominal,
  cooInd_b9465691.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_c4e29af7[nBui_disNet_c4e29af7]={
    cooInd_5a3d0cc9.mDis_flow_nominal,
  cooInd_b433d2ec.mDis_flow_nominal,
  cooInd_71df9072.mDis_flow_nominal,
  cooInd_e21a2366.mDis_flow_nominal,
  cooInd_dbcdcad2.mDis_flow_nominal,
  cooInd_810d4a17.mDis_flow_nominal,
  cooInd_1b3259f7.mDis_flow_nominal,
  cooInd_8ecb3fa6.mDis_flow_nominal,
  cooInd_7511120a.mDis_flow_nominal,
  cooInd_08deacc6.mDis_flow_nominal,
  cooInd_f3301ead.mDis_flow_nominal,
  cooInd_0c0ee305.mDis_flow_nominal,
  cooInd_b9465691.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_c4e29af7[nBui_disNet_c4e29af7](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_c4e29af7*0.1},
    fill(
      dp_nominal_disNet_c4e29af7*0.9/(nBui_disNet_c4e29af7-1),
      nBui_disNet_c4e29af7-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_c4e29af7=dpSetPoi_disNet_c4e29af7+nBui_disNet_c4e29af7*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_c4e29af7=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_c4e29af7(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_c4e29af7,
    iConDpSen=nBui_disNet_c4e29af7,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_c4e29af7,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_c4e29af7,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_c4e29af7)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,780.0},{-10.0,790.0}})));
  //
  // End Model Instance for disNet_c4e29af7
  //


  
  //
  // Begin Model Instance for cooPla_7b02862a
  // Source template: /model_connectors/plants/templates/CoolingPlant_Instance.mopt
  //
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal_cooPla_7b02862a=cooPla_7b02862a.numChi*(cooPla_7b02862a.perChi.mEva_flow_nominal)
    "Nominal chilled water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal_cooPla_7b02862a=cooPla_7b02862a.perChi.mCon_flow_nominal
    "Nominal condenser water mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dpCHW_nominal_cooPla_7b02862a=44.8*1000
    "Nominal chilled water side pressure";
  parameter Modelica.Units.SI.PressureDifference dpCW_nominal_cooPla_7b02862a=46.2*1000
    "Nominal condenser water side pressure";
  parameter Modelica.Units.SI.Power QEva_nominal_cooPla_7b02862a=mCHW_flow_nominal_cooPla_7b02862a*4200*(5-14)
    "Nominal cooling capaciaty (Negative means cooling)";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_cooPla_7b02862a=0.2*mCHW_flow_nominal_cooPla_7b02862a/cooPla_7b02862a.numChi
    "Minimum mass flow rate of single chiller";
  // control settings
  parameter Modelica.Units.SI.Pressure dpSetPoi_cooPla_7b02862a=70000
    "Differential pressure setpoint";
  parameter Modelica.Units.SI.Pressure pumDP_cooPla_7b02862a=dpCHW_nominal_cooPla_7b02862a+dpSetPoi_cooPla_7b02862a+200000;
  parameter Modelica.Units.SI.Time tWai_cooPla_7b02862a=30
    "Waiting time";
  // pumps
  parameter Buildings.Fluid.Movers.Data.Generic perCHWPum_cooPla_7b02862a(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=((mCHW_flow_nominal_cooPla_7b02862a/cooPla_7b02862a.numChi)/1000)*{0.1,1,1.2},
      dp=pumDP_cooPla_7b02862a*{1.2,1,0.1}))
    "Performance data for chilled water pumps";
  parameter Buildings.Fluid.Movers.Data.Generic perCWPum_cooPla_7b02862a(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mCW_flow_nominal_cooPla_7b02862a/1000*{0.2,0.6,1.0,1.2},
      dp=(dpCW_nominal_cooPla_7b02862a+60000+6000)*{1.2,1.1,1.0,0.6}))
    "Performance data for condenser water pumps";


  Modelica.Blocks.Sources.RealExpression TSetChiWatDis_cooPla_7b02862a(
    y=5+273.15)
    "Chilled water supply temperature set point on district level."
    annotation (Placement(transformation(extent={{10.0,-790.0},{30.0,-770.0}})));
  Modelica.Blocks.Sources.BooleanConstant on_cooPla_7b02862a
    "On signal of the plant"
    annotation (Placement(transformation(extent={{50.0,-790.0},{70.0,-770.0}})));

  baseline_demo.Plants.CentralCoolingPlant cooPla_7b02862a(
    redeclare Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19EX_5208kW_6_88COP_Vanes perChi,
    perCHWPum=perCHWPum_cooPla_7b02862a,
    perCWPum=perCWPum_cooPla_7b02862a,
    mCHW_flow_nominal=mCHW_flow_nominal_cooPla_7b02862a,
    dpCHW_nominal=dpCHW_nominal_cooPla_7b02862a,
    QEva_nominal=QEva_nominal_cooPla_7b02862a,
    mMin_flow=mMin_flow_cooPla_7b02862a,
    mCW_flow_nominal=mCW_flow_nominal_cooPla_7b02862a,
    dpCW_nominal=dpCW_nominal_cooPla_7b02862a,
    TAirInWB_nominal=298.7,
    TCW_nominal=308.15,
    TMin=288.15,
    tWai=tWai_cooPla_7b02862a,
    dpSetPoi=dpSetPoi_cooPla_7b02862a
    )
    "District cooling plant."
    annotation (Placement(transformation(extent={{-70.0,770.0},{-50.0,790.0}})));
  //
  // End Model Instance for cooPla_7b02862a
  //


  
  //
  // Begin Model Instance for disNet_d69ee963
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_d69ee963=13;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_d69ee963=sum({
    heaInd_ad7a3c5b.mDis_flow_nominal,
  heaInd_5f113052.mDis_flow_nominal,
  heaInd_aebed689.mDis_flow_nominal,
  heaInd_1a6adde7.mDis_flow_nominal,
  heaInd_0835c310.mDis_flow_nominal,
  heaInd_2599e700.mDis_flow_nominal,
  heaInd_15b8b780.mDis_flow_nominal,
  heaInd_c6a49d9d.mDis_flow_nominal,
  heaInd_6dbd67b3.mDis_flow_nominal,
  heaInd_08d638d5.mDis_flow_nominal,
  heaInd_75ba26e5.mDis_flow_nominal,
  heaInd_518226dd.mDis_flow_nominal,
  heaInd_d8a757c3.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_d69ee963[nBui_disNet_d69ee963]={
    heaInd_ad7a3c5b.mDis_flow_nominal,
  heaInd_5f113052.mDis_flow_nominal,
  heaInd_aebed689.mDis_flow_nominal,
  heaInd_1a6adde7.mDis_flow_nominal,
  heaInd_0835c310.mDis_flow_nominal,
  heaInd_2599e700.mDis_flow_nominal,
  heaInd_15b8b780.mDis_flow_nominal,
  heaInd_c6a49d9d.mDis_flow_nominal,
  heaInd_6dbd67b3.mDis_flow_nominal,
  heaInd_08d638d5.mDis_flow_nominal,
  heaInd_75ba26e5.mDis_flow_nominal,
  heaInd_518226dd.mDis_flow_nominal,
  heaInd_d8a757c3.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_d69ee963[nBui_disNet_d69ee963](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_d69ee963*0.1},
    fill(
      dp_nominal_disNet_d69ee963*0.9/(nBui_disNet_d69ee963-1),
      nBui_disNet_d69ee963-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_d69ee963=dpSetPoi_disNet_d69ee963+nBui_disNet_d69ee963*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_d69ee963=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_d69ee963(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_d69ee963,
    iConDpSen=nBui_disNet_d69ee963,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_d69ee963,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_d69ee963,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_d69ee963)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,740.0},{-10.0,750.0}})));
  //
  // End Model Instance for disNet_d69ee963
  //


  
  //
  // Begin Model Instance for heaPlac5422004
  // Source template: /model_connectors/plants/templates/HeatingPlant_Instance.mopt
  //
  // heating plant instance
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal_heaPlac5422004=mBoi_flow_nominal_heaPlac5422004*heaPlac5422004.numBoi
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal_heaPlac5422004=QBoi_nominal_heaPlac5422004/(4200*heaPlac5422004.delT_nominal)
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.Power QBoi_nominal_heaPlac5422004=Q_flow_nominal_heaPlac5422004/heaPlac5422004.numBoi
    "Nominal heating capaciaty";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_heaPlac5422004=1000000*2
    "Heating load";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_heaPlac5422004=0.2*mBoi_flow_nominal_heaPlac5422004
    "Minimum mass flow rate of single boiler";
  // controls
  parameter Modelica.Units.SI.Pressure pumDP=(heaPlac5422004.dpBoi_nominal+dpSetPoi_disNet_d69ee963+50000)
    "Heating water pump pressure drop";
  parameter Modelica.Units.SI.Time tWai_heaPlac5422004=30
    "Waiting time";
  parameter Buildings.Fluid.Movers.Data.Generic perHWPum_heaPlac5422004(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mBoi_flow_nominal_heaPlac5422004/1000*{0.1,1.1},
      dp=pumDP*{1.1,0.1}))
    "Performance data for heating water pumps";

  baseline_demo.Plants.CentralHeatingPlant heaPlac5422004(
    perHWPum=perHWPum_heaPlac5422004,
    mHW_flow_nominal=mHW_flow_nominal_heaPlac5422004,
    QBoi_flow_nominal=QBoi_nominal_heaPlac5422004,
    mMin_flow=mMin_flow_heaPlac5422004,
    mBoi_flow_nominal=mBoi_flow_nominal_heaPlac5422004,
    dpBoi_nominal=10000,
    delT_nominal(
      displayUnit="degC")=15,
    tWai=tWai_heaPlac5422004,
    // TODO: we're currently grabbing dpSetPoi from the Network instance -- need feedback to determine if that's the proper "home" for it
    dpSetPoi=dpSetPoi_disNet_d69ee963
    )
    "District heating plant."
    annotation (Placement(transformation(extent={{-70.0,730.0},{-50.0,750.0}})));
  //
  // End Model Instance for heaPlac5422004
  //


  
  //
  // Begin Model Instance for TimeSerLoa_b9d7c0fd
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B1.TimeSeriesBuilding TimeSerLoa_b9d7c0fd(
    
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
  // End Model Instance for TimeSerLoa_b9d7c0fd
  //


  
  //
  // Begin Model Instance for cooInd_5a3d0cc9
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_1 cooInd_5a3d0cc9(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_7c5d908d,
    mBui_flow_nominal=mBui_flow_nominal_7c5d908d,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_7c5d908d,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,770.0},{30.0,790.0}})));
  //
  // End Model Instance for cooInd_5a3d0cc9
  //


  
  //
  // Begin Model Instance for heaInd_ad7a3c5b
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_1 heaInd_ad7a3c5b(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_18fc0592,
    mBui_flow_nominal=mBui_flow_nominal_18fc0592,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_18fc0592,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,730.0},{30.0,750.0}})));
  //
  // End Model Instance for heaInd_ad7a3c5b
  //


  
  //
  // Begin Model Instance for TimeSerLoa_d42aed2f
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B2.TimeSeriesBuilding TimeSerLoa_d42aed2f(
    
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
  // End Model Instance for TimeSerLoa_d42aed2f
  //


  
  //
  // Begin Model Instance for cooInd_b433d2ec
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_2 cooInd_b433d2ec(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_e5175857,
    mBui_flow_nominal=mBui_flow_nominal_e5175857,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_e5175857,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,690.0},{30.0,710.0}})));
  //
  // End Model Instance for cooInd_b433d2ec
  //


  
  //
  // Begin Model Instance for heaInd_5f113052
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_2 heaInd_5f113052(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_901e3563,
    mBui_flow_nominal=mBui_flow_nominal_901e3563,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_901e3563,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,650.0},{30.0,670.0}})));
  //
  // End Model Instance for heaInd_5f113052
  //


  
  //
  // Begin Model Instance for TimeSerLoa_6ad3533e
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B3.TimeSeriesBuilding TimeSerLoa_6ad3533e(
    
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
  // End Model Instance for TimeSerLoa_6ad3533e
  //


  
  //
  // Begin Model Instance for cooInd_71df9072
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_3 cooInd_71df9072(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_4a226a2a,
    mBui_flow_nominal=mBui_flow_nominal_4a226a2a,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_4a226a2a,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,610.0},{30.0,630.0}})));
  //
  // End Model Instance for cooInd_71df9072
  //


  
  //
  // Begin Model Instance for heaInd_aebed689
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_3 heaInd_aebed689(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_823fe32b,
    mBui_flow_nominal=mBui_flow_nominal_823fe32b,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_823fe32b,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,570.0},{30.0,590.0}})));
  //
  // End Model Instance for heaInd_aebed689
  //


  
  //
  // Begin Model Instance for TimeSerLoa_3faa3aa6
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B4.TimeSeriesBuilding TimeSerLoa_3faa3aa6(
    
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
  // End Model Instance for TimeSerLoa_3faa3aa6
  //


  
  //
  // Begin Model Instance for cooInd_e21a2366
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_4 cooInd_e21a2366(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_258db06f,
    mBui_flow_nominal=mBui_flow_nominal_258db06f,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_258db06f,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,490.0},{30.0,510.0}})));
  //
  // End Model Instance for cooInd_e21a2366
  //


  
  //
  // Begin Model Instance for heaInd_1a6adde7
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_4 heaInd_1a6adde7(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_7b472f1e,
    mBui_flow_nominal=mBui_flow_nominal_7b472f1e,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_7b472f1e,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,530.0},{30.0,550.0}})));
  //
  // End Model Instance for heaInd_1a6adde7
  //


  
  //
  // Begin Model Instance for TimeSerLoa_4c7e5c88
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B5.TimeSeriesBuilding TimeSerLoa_4c7e5c88(
    
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
  // End Model Instance for TimeSerLoa_4c7e5c88
  //


  
  //
  // Begin Model Instance for cooInd_dbcdcad2
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_5 cooInd_dbcdcad2(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_a3934b5d,
    mBui_flow_nominal=mBui_flow_nominal_a3934b5d,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_a3934b5d,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,450.0},{30.0,470.0}})));
  //
  // End Model Instance for cooInd_dbcdcad2
  //


  
  //
  // Begin Model Instance for heaInd_0835c310
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_5 heaInd_0835c310(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_a6815496,
    mBui_flow_nominal=mBui_flow_nominal_a6815496,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_a6815496,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,410.0},{30.0,430.0}})));
  //
  // End Model Instance for heaInd_0835c310
  //


  
  //
  // Begin Model Instance for TimeSerLoa_cb0bd5f5
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B6.TimeSeriesBuilding TimeSerLoa_cb0bd5f5(
    
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
  // End Model Instance for TimeSerLoa_cb0bd5f5
  //


  
  //
  // Begin Model Instance for cooInd_810d4a17
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_6 cooInd_810d4a17(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_4b8ea6e0,
    mBui_flow_nominal=mBui_flow_nominal_4b8ea6e0,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_4b8ea6e0,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,370.0},{30.0,390.0}})));
  //
  // End Model Instance for cooInd_810d4a17
  //


  
  //
  // Begin Model Instance for heaInd_2599e700
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_6 heaInd_2599e700(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_e87e0fc3,
    mBui_flow_nominal=mBui_flow_nominal_e87e0fc3,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_e87e0fc3,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,330.0},{30.0,350.0}})));
  //
  // End Model Instance for heaInd_2599e700
  //


  
  //
  // Begin Model Instance for TimeSerLoa_243d819e
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B7.TimeSeriesBuilding TimeSerLoa_243d819e(
    
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
  // End Model Instance for TimeSerLoa_243d819e
  //


  
  //
  // Begin Model Instance for cooInd_1b3259f7
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_7 cooInd_1b3259f7(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_053e7841,
    mBui_flow_nominal=mBui_flow_nominal_053e7841,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_053e7841,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,250.0},{30.0,270.0}})));
  //
  // End Model Instance for cooInd_1b3259f7
  //


  
  //
  // Begin Model Instance for heaInd_15b8b780
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_7 heaInd_15b8b780(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_88d1a97b,
    mBui_flow_nominal=mBui_flow_nominal_88d1a97b,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_88d1a97b,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,290.0},{30.0,310.0}})));
  //
  // End Model Instance for heaInd_15b8b780
  //


  
  //
  // Begin Model Instance for TimeSerLoa_f54d656c
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B8.TimeSeriesBuilding TimeSerLoa_f54d656c(
    
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
  // End Model Instance for TimeSerLoa_f54d656c
  //


  
  //
  // Begin Model Instance for cooInd_8ecb3fa6
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_8 cooInd_8ecb3fa6(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_cb6a012f,
    mBui_flow_nominal=mBui_flow_nominal_cb6a012f,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_cb6a012f,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,170.0},{30.0,190.0}})));
  //
  // End Model Instance for cooInd_8ecb3fa6
  //


  
  //
  // Begin Model Instance for heaInd_c6a49d9d
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_8 heaInd_c6a49d9d(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_48a21ccd,
    mBui_flow_nominal=mBui_flow_nominal_48a21ccd,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_48a21ccd,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,210.0},{30.0,230.0}})));
  //
  // End Model Instance for heaInd_c6a49d9d
  //


  
  //
  // Begin Model Instance for TimeSerLoa_898b2762
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B9.TimeSeriesBuilding TimeSerLoa_898b2762(
    
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
  // End Model Instance for TimeSerLoa_898b2762
  //


  
  //
  // Begin Model Instance for cooInd_7511120a
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_9 cooInd_7511120a(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_c8ff26e5,
    mBui_flow_nominal=mBui_flow_nominal_c8ff26e5,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_c8ff26e5,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,130.0},{30.0,150.0}})));
  //
  // End Model Instance for cooInd_7511120a
  //


  
  //
  // Begin Model Instance for heaInd_6dbd67b3
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_9 heaInd_6dbd67b3(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_151fe7e1,
    mBui_flow_nominal=mBui_flow_nominal_151fe7e1,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_151fe7e1,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,90.0},{30.0,110.0}})));
  //
  // End Model Instance for heaInd_6dbd67b3
  //


  
  //
  // Begin Model Instance for TimeSerLoa_b26ccb55
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B10.TimeSeriesBuilding TimeSerLoa_b26ccb55(
    
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
  // End Model Instance for TimeSerLoa_b26ccb55
  //


  
  //
  // Begin Model Instance for cooInd_08deacc6
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_10 cooInd_08deacc6(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_94bfb6a1,
    mBui_flow_nominal=mBui_flow_nominal_94bfb6a1,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_94bfb6a1,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,50.0},{30.0,70.0}})));
  //
  // End Model Instance for cooInd_08deacc6
  //


  
  //
  // Begin Model Instance for heaInd_08d638d5
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_10 heaInd_08d638d5(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_8195cf4d,
    mBui_flow_nominal=mBui_flow_nominal_8195cf4d,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_8195cf4d,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,10.0},{30.0,30.0}})));
  //
  // End Model Instance for heaInd_08d638d5
  //


  
  //
  // Begin Model Instance for TimeSerLoa_4c16f6a9
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B11.TimeSeriesBuilding TimeSerLoa_4c16f6a9(
    
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
  // End Model Instance for TimeSerLoa_4c16f6a9
  //


  
  //
  // Begin Model Instance for cooInd_f3301ead
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_11 cooInd_f3301ead(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_9faf519c,
    mBui_flow_nominal=mBui_flow_nominal_9faf519c,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_9faf519c,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,-30.0},{30.0,-10.0}})));
  //
  // End Model Instance for cooInd_f3301ead
  //


  
  //
  // Begin Model Instance for heaInd_75ba26e5
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_11 heaInd_75ba26e5(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_0d7b23e4,
    mBui_flow_nominal=mBui_flow_nominal_0d7b23e4,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_0d7b23e4,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,-70.0},{30.0,-50.0}})));
  //
  // End Model Instance for heaInd_75ba26e5
  //


  
  //
  // Begin Model Instance for TimeSerLoa_46c51900
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B12.TimeSeriesBuilding TimeSerLoa_46c51900(
    
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
  // End Model Instance for TimeSerLoa_46c51900
  //


  
  //
  // Begin Model Instance for cooInd_0c0ee305
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_12 cooInd_0c0ee305(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_64fb8580,
    mBui_flow_nominal=mBui_flow_nominal_64fb8580,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_64fb8580,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,-110.0},{30.0,-90.0}})));
  //
  // End Model Instance for cooInd_0c0ee305
  //


  
  //
  // Begin Model Instance for heaInd_518226dd
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_12 heaInd_518226dd(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_5685d516,
    mBui_flow_nominal=mBui_flow_nominal_5685d516,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_5685d516,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,-150.0},{30.0,-130.0}})));
  //
  // End Model Instance for heaInd_518226dd
  //


  
  //
  // Begin Model Instance for TimeSerLoa_2561f077
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  baseline_demo.Loads.B13.TimeSeriesBuilding TimeSerLoa_2561f077(
    
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
  // End Model Instance for TimeSerLoa_2561f077
  //


  
  //
  // Begin Model Instance for cooInd_b9465691
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  baseline_demo.Substations.CoolingIndirect_13 cooInd_b9465691(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_dd3d24c6,
    mBui_flow_nominal=mBui_flow_nominal_dd3d24c6,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_dd3d24c6,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,-230.0},{30.0,-210.0}})));
  //
  // End Model Instance for cooInd_b9465691
  //


  
  //
  // Begin Model Instance for heaInd_d8a757c3
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  baseline_demo.Substations.HeatingIndirect_13 heaInd_d8a757c3(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_13386826,
    mBui_flow_nominal=mBui_flow_nominal_13386826,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_13386826,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,-190.0},{30.0,-170.0}})));
  //
  // End Model Instance for heaInd_d8a757c3
  //


  

  // Model dependencies

  //
  // Begin Component Definitions for c352ef84
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ComponentDefinitions.mopt
  //
  // No components for pipe and cooling plant

  //
  // End Component Definitions for c352ef84
  //



  //
  // Begin Component Definitions for fca5ffe1
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ComponentDefinitions.mopt
  //
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.BooleanConstant mPum_flow_fca5ffe1(
    k=true)
    "Total heating water pump mass flow rate"
    annotation (Placement(transformation(extent={{-70.0,-270.0},{-50.0,-250.0}})));
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.RealExpression TDisSetHeaWat_fca5ffe1(
    each y=273.15+54)
    "District side heating water supply temperature set point."
    annotation (Placement(transformation(extent={{-30.0,-270.0},{-10.0,-250.0}})));

  //
  // End Component Definitions for fca5ffe1
  //



  //
  // Begin Component Definitions for 7c5d908d
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_7c5d908d=TimeSerLoa_b9d7c0fd.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_7c5d908d=TimeSerLoa_b9d7c0fd.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_7c5d908d=-1*(TimeSerLoa_b9d7c0fd.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_7c5d908d(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-270.0},{30.0,-250.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_7c5d908d(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-270.0},{70.0,-250.0}})));

  //
  // End Component Definitions for 7c5d908d
  //



  //
  // Begin Component Definitions for 5b3030bb
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 5b3030bb
  //



  //
  // Begin Component Definitions for 18fc0592
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_18fc0592=TimeSerLoa_b9d7c0fd.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_18fc0592=TimeSerLoa_b9d7c0fd.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_18fc0592=(TimeSerLoa_b9d7c0fd.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_18fc0592(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-310.0},{-50.0,-290.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_18fc0592(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-310.0},{-10.0,-290.0}})));

  //
  // End Component Definitions for 18fc0592
  //



  //
  // Begin Component Definitions for 8de55549
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 8de55549
  //



  //
  // Begin Component Definitions for e5175857
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_e5175857=TimeSerLoa_d42aed2f.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_e5175857=TimeSerLoa_d42aed2f.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_e5175857=-1*(TimeSerLoa_d42aed2f.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_e5175857(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-310.0},{30.0,-290.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_e5175857(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-310.0},{70.0,-290.0}})));

  //
  // End Component Definitions for e5175857
  //



  //
  // Begin Component Definitions for 0805f439
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 0805f439
  //



  //
  // Begin Component Definitions for 901e3563
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_901e3563=TimeSerLoa_d42aed2f.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_901e3563=TimeSerLoa_d42aed2f.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_901e3563=(TimeSerLoa_d42aed2f.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_901e3563(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-350.0},{-50.0,-330.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_901e3563(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-350.0},{-10.0,-330.0}})));

  //
  // End Component Definitions for 901e3563
  //



  //
  // Begin Component Definitions for 916e5d56
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 916e5d56
  //



  //
  // Begin Component Definitions for 4a226a2a
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_4a226a2a=TimeSerLoa_6ad3533e.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_4a226a2a=TimeSerLoa_6ad3533e.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_4a226a2a=-1*(TimeSerLoa_6ad3533e.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_4a226a2a(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-350.0},{30.0,-330.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_4a226a2a(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-350.0},{70.0,-330.0}})));

  //
  // End Component Definitions for 4a226a2a
  //



  //
  // Begin Component Definitions for 078a1b5f
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 078a1b5f
  //



  //
  // Begin Component Definitions for 823fe32b
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_823fe32b=TimeSerLoa_6ad3533e.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_823fe32b=TimeSerLoa_6ad3533e.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_823fe32b=(TimeSerLoa_6ad3533e.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_823fe32b(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-390.0},{-50.0,-370.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_823fe32b(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-390.0},{-10.0,-370.0}})));

  //
  // End Component Definitions for 823fe32b
  //



  //
  // Begin Component Definitions for 23bb2127
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 23bb2127
  //



  //
  // Begin Component Definitions for 258db06f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_258db06f=TimeSerLoa_3faa3aa6.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_258db06f=TimeSerLoa_3faa3aa6.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_258db06f=-1*(TimeSerLoa_3faa3aa6.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_258db06f(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-390.0},{30.0,-370.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_258db06f(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-390.0},{70.0,-370.0}})));

  //
  // End Component Definitions for 258db06f
  //



  //
  // Begin Component Definitions for c8432462
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for c8432462
  //



  //
  // Begin Component Definitions for 7b472f1e
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_7b472f1e=TimeSerLoa_3faa3aa6.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_7b472f1e=TimeSerLoa_3faa3aa6.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_7b472f1e=(TimeSerLoa_3faa3aa6.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_7b472f1e(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-430.0},{-50.0,-410.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_7b472f1e(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-430.0},{-10.0,-410.0}})));

  //
  // End Component Definitions for 7b472f1e
  //



  //
  // Begin Component Definitions for f45ff8f7
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for f45ff8f7
  //



  //
  // Begin Component Definitions for a3934b5d
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_a3934b5d=TimeSerLoa_4c7e5c88.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_a3934b5d=TimeSerLoa_4c7e5c88.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_a3934b5d=-1*(TimeSerLoa_4c7e5c88.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_a3934b5d(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-430.0},{30.0,-410.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_a3934b5d(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-430.0},{70.0,-410.0}})));

  //
  // End Component Definitions for a3934b5d
  //



  //
  // Begin Component Definitions for 89d7f0d0
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 89d7f0d0
  //



  //
  // Begin Component Definitions for a6815496
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_a6815496=TimeSerLoa_4c7e5c88.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_a6815496=TimeSerLoa_4c7e5c88.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_a6815496=(TimeSerLoa_4c7e5c88.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_a6815496(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-470.0},{-50.0,-450.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_a6815496(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-470.0},{-10.0,-450.0}})));

  //
  // End Component Definitions for a6815496
  //



  //
  // Begin Component Definitions for b7be70c0
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for b7be70c0
  //



  //
  // Begin Component Definitions for 4b8ea6e0
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_4b8ea6e0=TimeSerLoa_cb0bd5f5.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_4b8ea6e0=TimeSerLoa_cb0bd5f5.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_4b8ea6e0=-1*(TimeSerLoa_cb0bd5f5.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_4b8ea6e0(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-470.0},{30.0,-450.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_4b8ea6e0(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-470.0},{70.0,-450.0}})));

  //
  // End Component Definitions for 4b8ea6e0
  //



  //
  // Begin Component Definitions for 05d7d371
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 05d7d371
  //



  //
  // Begin Component Definitions for e87e0fc3
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_e87e0fc3=TimeSerLoa_cb0bd5f5.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_e87e0fc3=TimeSerLoa_cb0bd5f5.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_e87e0fc3=(TimeSerLoa_cb0bd5f5.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_e87e0fc3(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-510.0},{-50.0,-490.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_e87e0fc3(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-510.0},{-10.0,-490.0}})));

  //
  // End Component Definitions for e87e0fc3
  //



  //
  // Begin Component Definitions for 07c22e2c
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 07c22e2c
  //



  //
  // Begin Component Definitions for 053e7841
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_053e7841=TimeSerLoa_243d819e.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_053e7841=TimeSerLoa_243d819e.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_053e7841=-1*(TimeSerLoa_243d819e.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_053e7841(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-510.0},{30.0,-490.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_053e7841(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-510.0},{70.0,-490.0}})));

  //
  // End Component Definitions for 053e7841
  //



  //
  // Begin Component Definitions for b669f535
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for b669f535
  //



  //
  // Begin Component Definitions for 88d1a97b
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_88d1a97b=TimeSerLoa_243d819e.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_88d1a97b=TimeSerLoa_243d819e.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_88d1a97b=(TimeSerLoa_243d819e.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_88d1a97b(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-550.0},{-50.0,-530.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_88d1a97b(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-550.0},{-10.0,-530.0}})));

  //
  // End Component Definitions for 88d1a97b
  //



  //
  // Begin Component Definitions for f7f245c6
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for f7f245c6
  //



  //
  // Begin Component Definitions for cb6a012f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_cb6a012f=TimeSerLoa_f54d656c.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_cb6a012f=TimeSerLoa_f54d656c.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_cb6a012f=-1*(TimeSerLoa_f54d656c.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_cb6a012f(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-550.0},{30.0,-530.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_cb6a012f(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-550.0},{70.0,-530.0}})));

  //
  // End Component Definitions for cb6a012f
  //



  //
  // Begin Component Definitions for 8526c97e
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 8526c97e
  //



  //
  // Begin Component Definitions for 48a21ccd
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_48a21ccd=TimeSerLoa_f54d656c.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_48a21ccd=TimeSerLoa_f54d656c.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_48a21ccd=(TimeSerLoa_f54d656c.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_48a21ccd(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-590.0},{-50.0,-570.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_48a21ccd(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-590.0},{-10.0,-570.0}})));

  //
  // End Component Definitions for 48a21ccd
  //



  //
  // Begin Component Definitions for dc22ae51
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for dc22ae51
  //



  //
  // Begin Component Definitions for c8ff26e5
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_c8ff26e5=TimeSerLoa_898b2762.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_c8ff26e5=TimeSerLoa_898b2762.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_c8ff26e5=-1*(TimeSerLoa_898b2762.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_c8ff26e5(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-590.0},{30.0,-570.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_c8ff26e5(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-590.0},{70.0,-570.0}})));

  //
  // End Component Definitions for c8ff26e5
  //



  //
  // Begin Component Definitions for 23f81f2b
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 23f81f2b
  //



  //
  // Begin Component Definitions for 151fe7e1
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_151fe7e1=TimeSerLoa_898b2762.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_151fe7e1=TimeSerLoa_898b2762.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_151fe7e1=(TimeSerLoa_898b2762.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_151fe7e1(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-630.0},{-50.0,-610.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_151fe7e1(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-630.0},{-10.0,-610.0}})));

  //
  // End Component Definitions for 151fe7e1
  //



  //
  // Begin Component Definitions for 6fc25637
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 6fc25637
  //



  //
  // Begin Component Definitions for 94bfb6a1
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_94bfb6a1=TimeSerLoa_b26ccb55.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_94bfb6a1=TimeSerLoa_b26ccb55.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_94bfb6a1=-1*(TimeSerLoa_b26ccb55.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_94bfb6a1(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-630.0},{30.0,-610.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_94bfb6a1(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-630.0},{70.0,-610.0}})));

  //
  // End Component Definitions for 94bfb6a1
  //



  //
  // Begin Component Definitions for e0c4f24e
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for e0c4f24e
  //



  //
  // Begin Component Definitions for 8195cf4d
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_8195cf4d=TimeSerLoa_b26ccb55.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_8195cf4d=TimeSerLoa_b26ccb55.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_8195cf4d=(TimeSerLoa_b26ccb55.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_8195cf4d(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-670.0},{-50.0,-650.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_8195cf4d(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-670.0},{-10.0,-650.0}})));

  //
  // End Component Definitions for 8195cf4d
  //



  //
  // Begin Component Definitions for 7d7fe20e
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 7d7fe20e
  //



  //
  // Begin Component Definitions for 9faf519c
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_9faf519c=TimeSerLoa_4c16f6a9.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_9faf519c=TimeSerLoa_4c16f6a9.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_9faf519c=-1*(TimeSerLoa_4c16f6a9.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_9faf519c(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-670.0},{30.0,-650.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_9faf519c(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-670.0},{70.0,-650.0}})));

  //
  // End Component Definitions for 9faf519c
  //



  //
  // Begin Component Definitions for 86d4747e
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 86d4747e
  //



  //
  // Begin Component Definitions for 0d7b23e4
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_0d7b23e4=TimeSerLoa_4c16f6a9.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_0d7b23e4=TimeSerLoa_4c16f6a9.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_0d7b23e4=(TimeSerLoa_4c16f6a9.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_0d7b23e4(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-710.0},{-50.0,-690.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_0d7b23e4(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-710.0},{-10.0,-690.0}})));

  //
  // End Component Definitions for 0d7b23e4
  //



  //
  // Begin Component Definitions for 4ab595fa
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 4ab595fa
  //



  //
  // Begin Component Definitions for 64fb8580
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_64fb8580=TimeSerLoa_46c51900.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_64fb8580=TimeSerLoa_46c51900.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_64fb8580=-1*(TimeSerLoa_46c51900.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_64fb8580(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-710.0},{30.0,-690.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_64fb8580(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-710.0},{70.0,-690.0}})));

  //
  // End Component Definitions for 64fb8580
  //



  //
  // Begin Component Definitions for b1d91a23
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for b1d91a23
  //



  //
  // Begin Component Definitions for 5685d516
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_5685d516=TimeSerLoa_46c51900.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_5685d516=TimeSerLoa_46c51900.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_5685d516=(TimeSerLoa_46c51900.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_5685d516(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-750.0},{-50.0,-730.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_5685d516(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-750.0},{-10.0,-730.0}})));

  //
  // End Component Definitions for 5685d516
  //



  //
  // Begin Component Definitions for f76aeb36
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for f76aeb36
  //



  //
  // Begin Component Definitions for dd3d24c6
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_dd3d24c6=TimeSerLoa_2561f077.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_dd3d24c6=TimeSerLoa_2561f077.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_dd3d24c6=-1*(TimeSerLoa_2561f077.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_dd3d24c6(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-750.0},{30.0,-730.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_dd3d24c6(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-750.0},{70.0,-730.0}})));

  //
  // End Component Definitions for dd3d24c6
  //



  //
  // Begin Component Definitions for 4a4eaa29
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 4a4eaa29
  //



  //
  // Begin Component Definitions for 13386826
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_13386826=TimeSerLoa_2561f077.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_13386826=TimeSerLoa_2561f077.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_13386826=(TimeSerLoa_2561f077.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_13386826(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-790.0},{-50.0,-770.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_13386826(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-790.0},{-10.0,-770.0}})));

  //
  // End Component Definitions for 13386826
  //



  //
  // Begin Component Definitions for ac6c2645
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for ac6c2645
  //



equation
  // Connections

  //
  // Begin Connect Statements for c352ef84
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ConnectStatements.mopt
  //

  // TODO: these connect statements shouldn't be here, they are plant specific
  // but since we can't currently make connect statements for single systems, this is what we've got
  connect(on_cooPla_7b02862a.y,cooPla_7b02862a.on)
    annotation (Line(points={{64.54643934906605,-758.9235291717075},{44.54643934906605,-758.9235291717075},{44.54643934906605,-738.9235291717075},{44.54643934906605,-718.9235291717075},{44.54643934906605,-698.9235291717075},{44.54643934906605,-678.9235291717075},{44.54643934906605,-658.9235291717075},{44.54643934906605,-638.9235291717075},{44.54643934906605,-618.9235291717075},{44.54643934906605,-598.9235291717075},{44.54643934906605,-578.9235291717075},{44.54643934906605,-558.9235291717075},{44.54643934906605,-538.9235291717075},{44.54643934906605,-518.9235291717075},{44.54643934906605,-498.9235291717075},{44.54643934906605,-478.9235291717075},{44.54643934906605,-458.9235291717075},{44.54643934906605,-438.9235291717075},{44.54643934906605,-418.9235291717075},{44.54643934906605,-398.9235291717075},{44.54643934906605,-378.9235291717075},{44.54643934906605,-358.9235291717075},{44.54643934906605,-338.9235291717075},{44.54643934906605,-318.9235291717075},{44.54643934906605,-298.9235291717075},{44.54643934906605,-278.9235291717075},{44.54643934906605,-258.9235291717075},{44.54643934906605,-238.92352917170751},{44.54643934906605,-218.92352917170751},{44.54643934906605,-198.92352917170763},{44.54643934906605,-178.92352917170763},{44.54643934906605,-158.92352917170763},{44.54643934906605,-138.92352917170763},{44.54643934906605,-118.92352917170763},{44.54643934906605,-98.92352917170763},{44.54643934906605,-78.92352917170763},{44.54643934906605,-58.92352917170763},{44.54643934906605,-38.92352917170763},{44.54643934906605,-18.923529171707628},{44.54643934906605,1.076470828292372},{44.54643934906605,21.076470828292372},{44.54643934906605,41.07647082829237},{44.54643934906605,61.07647082829237},{44.54643934906605,81.07647082829237},{44.54643934906605,101.07647082829237},{44.54643934906605,121.07647082829237},{44.54643934906605,141.07647082829237},{44.54643934906605,161.07647082829237},{44.54643934906605,181.07647082829237},{44.54643934906605,201.07647082829237},{44.54643934906605,221.07647082829237},{44.54643934906605,241.07647082829237},{44.54643934906605,261.0764708282924},{44.54643934906605,281.0764708282924},{44.54643934906605,301.07647082829243},{44.54643934906605,321.07647082829243},{44.54643934906605,341.07647082829243},{44.54643934906605,361.07647082829243},{44.54643934906605,381.07647082829243},{44.54643934906605,401.07647082829243},{44.54643934906605,421.07647082829243},{44.54643934906605,441.07647082829243},{44.54643934906605,461.07647082829243},{44.54643934906605,481.07647082829243},{44.54643934906605,501.07647082829243},{44.54643934906605,521.0764708282925},{44.54643934906605,541.0764708282925},{44.54643934906605,561.0764708282925},{44.54643934906605,581.0764708282925},{44.54643934906605,601.0764708282925},{44.54643934906605,621.0764708282925},{44.54643934906605,641.0764708282925},{44.54643934906605,661.0764708282925},{44.54643934906605,681.0764708282925},{44.54643934906605,701.0764708282924},{44.54643934906605,721.0764708282924},{44.54643934906605,741.0764708282924},{44.54643934906605,761.0764708282924},{24.54643934906605,761.0764708282924},{4.546439349066048,761.0764708282924},{-15.453560650933952,761.0764708282924},{-35.453560650933944,761.0764708282924},{-35.453560650933944,781.0764708282924},{-55.453560650933944,781.0764708282924}},color={0,0,127}));
  connect(TSetChiWatDis_cooPla_7b02862a.y,cooPla_7b02862a.TCHWSupSet)
    annotation (Line(points={{27.997043857395028,-754.9881367347414},{7.9970438573950275,-754.9881367347414},{7.9970438573950275,-734.9881367347414},{7.9970438573950275,-714.9881367347414},{7.9970438573950275,-694.9881367347414},{7.9970438573950275,-674.9881367347414},{7.9970438573950275,-654.9881367347414},{7.9970438573950275,-634.9881367347414},{7.9970438573950275,-614.9881367347414},{7.9970438573950275,-594.9881367347414},{7.9970438573950275,-574.9881367347414},{7.9970438573950275,-554.9881367347414},{7.9970438573950275,-534.9881367347414},{7.9970438573950275,-514.9881367347414},{7.9970438573950275,-494.9881367347414},{7.9970438573950275,-474.9881367347414},{7.9970438573950275,-454.9881367347414},{7.9970438573950275,-434.9881367347414},{7.9970438573950275,-414.9881367347414},{7.9970438573950275,-394.9881367347414},{7.9970438573950275,-374.9881367347414},{7.9970438573950275,-354.9881367347414},{7.9970438573950275,-334.9881367347414},{7.9970438573950275,-314.9881367347414},{7.9970438573950275,-294.9881367347414},{7.9970438573950275,-274.9881367347414},{7.9970438573950275,-254.98813673474137},{7.9970438573950275,-234.98813673474137},{7.9970438573950275,-214.98813673474137},{7.9970438573950275,-194.98813673474137},{7.9970438573950275,-174.98813673474137},{7.9970438573950275,-154.98813673474137},{7.9970438573950275,-134.98813673474137},{7.9970438573950275,-114.98813673474137},{7.9970438573950275,-94.98813673474137},{7.9970438573950275,-74.98813673474137},{7.9970438573950275,-54.988136734741374},{7.9970438573950275,-34.988136734741374},{7.9970438573950275,-14.988136734741374},{7.9970438573950275,5.011863265258626},{7.9970438573950275,25.011863265258626},{7.9970438573950275,45.011863265258626},{7.9970438573950275,65.01186326525863},{7.9970438573950275,85.01186326525863},{7.9970438573950275,105.01186326525863},{7.9970438573950275,125.01186326525863},{7.9970438573950275,145.01186326525863},{7.9970438573950275,165.01186326525863},{7.9970438573950275,185.01186326525863},{7.9970438573950275,205.01186326525863},{7.9970438573950275,225.01186326525863},{7.9970438573950275,245.01186326525863},{7.9970438573950275,265.0118632652586},{7.9970438573950275,285.0118632652586},{7.9970438573950275,305.0118632652587},{7.9970438573950275,325.0118632652587},{7.9970438573950275,345.0118632652587},{7.9970438573950275,365.0118632652587},{7.9970438573950275,385.0118632652587},{7.9970438573950275,405.0118632652587},{7.9970438573950275,425.0118632652587},{7.9970438573950275,445.0118632652587},{7.9970438573950275,465.0118632652587},{7.9970438573950275,485.0118632652587},{7.9970438573950275,505.0118632652587},{7.9970438573950275,525.0118632652586},{7.9970438573950275,545.0118632652586},{7.9970438573950275,565.0118632652586},{7.9970438573950275,585.0118632652586},{7.9970438573950275,605.0118632652586},{7.9970438573950275,625.0118632652586},{7.9970438573950275,645.0118632652586},{7.9970438573950275,665.0118632652586},{7.9970438573950275,685.0118632652586},{7.9970438573950275,705.0118632652586},{7.9970438573950275,725.0118632652586},{7.9970438573950275,745.0118632652586},{7.9970438573950275,765.0118632652586},{-12.002956142604972,765.0118632652586},{-32.00295614260497,765.0118632652586},{-32.00295614260497,785.0118632652586},{-52.00295614260497,785.0118632652586}},color={0,0,127}));

  connect(disNet_c4e29af7.port_bDisRet,cooPla_7b02862a.port_a)
    annotation (Line(points={{-44.29059499164225,772.3091859708283},{-64.29059499164225,772.3091859708283}},color={0,0,127}));
  connect(cooPla_7b02862a.port_b,disNet_c4e29af7.port_aDisSup)
    annotation (Line(points={{-48.488984404947644,773.5163586673675},{-28.488984404947644,773.5163586673675}},color={0,0,127}));
  connect(disNet_c4e29af7.dp,cooPla_7b02862a.dpMea)
    annotation (Line(points={{-47.97514226286626,784.2954627705527},{-67.97514226286626,784.2954627705527}},color={0,0,127}));

  //
  // End Connect Statements for c352ef84
  //



  //
  // Begin Connect Statements for fca5ffe1
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ConnectStatements.mopt
  //

  connect(heaPlac5422004.port_a,disNet_d69ee963.port_bDisRet)
    annotation (Line(points={{-33.72032219035683,748.5768796658786},{-13.720322190356825,748.5768796658786}},color={0,0,127}));
  connect(disNet_d69ee963.dp,heaPlac5422004.dpMea)
    annotation (Line(points={{-44.74875561990391,749.3388023103588},{-64.7487556199039,749.3388023103588}},color={0,0,127}));
  connect(heaPlac5422004.port_b,disNet_d69ee963.port_aDisSup)
    annotation (Line(points={{-44.58628872515634,730.9243716330218},{-24.586288725156336,730.9243716330218}},color={0,0,127}));
  connect(mPum_flow_fca5ffe1.y,heaPlac5422004.on)
    annotation (Line(points={{-51.99833658539758,-230.79488557576155},{-51.99833658539758,-210.79488557576144},{-51.99833658539758,-190.79488557576144},{-51.99833658539758,-170.79488557576144},{-51.99833658539758,-150.79488557576144},{-51.99833658539758,-130.79488557576144},{-51.99833658539758,-110.79488557576144},{-51.99833658539758,-90.79488557576144},{-51.99833658539758,-70.79488557576144},{-51.99833658539758,-50.79488557576144},{-51.99833658539758,-30.79488557576144},{-51.99833658539758,-10.794885575761441},{-51.99833658539758,9.205114424238559},{-51.99833658539758,29.20511442423856},{-51.99833658539758,49.20511442423856},{-51.99833658539758,69.20511442423856},{-51.99833658539758,89.20511442423856},{-51.99833658539758,109.20511442423856},{-51.99833658539758,129.20511442423856},{-51.99833658539758,149.20511442423856},{-51.99833658539758,169.20511442423856},{-51.99833658539758,189.20511442423856},{-51.99833658539758,209.20511442423856},{-51.99833658539758,229.20511442423856},{-51.99833658539758,249.20511442423856},{-51.99833658539758,269.20511442423856},{-51.99833658539758,289.20511442423856},{-51.99833658539758,309.20511442423856},{-51.99833658539758,329.20511442423856},{-51.99833658539758,349.20511442423856},{-51.99833658539758,369.20511442423856},{-51.99833658539758,389.20511442423856},{-51.99833658539758,409.20511442423856},{-51.99833658539758,429.20511442423856},{-51.99833658539758,449.20511442423856},{-51.99833658539758,469.20511442423856},{-51.99833658539758,489.20511442423856},{-51.99833658539758,509.20511442423856},{-51.99833658539758,529.2051144242386},{-51.99833658539758,549.2051144242386},{-51.99833658539758,569.2051144242386},{-51.99833658539758,589.2051144242386},{-51.99833658539758,609.2051144242386},{-51.99833658539758,629.2051144242386},{-51.99833658539758,649.2051144242386},{-51.99833658539758,669.2051144242386},{-51.99833658539758,689.2051144242386},{-51.99833658539758,709.2051144242386},{-51.99833658539758,729.2051144242386},{-51.99833658539758,749.2051144242386}},color={0,0,127}));
  connect(TDisSetHeaWat_fca5ffe1.y,heaPlac5422004.THeaSet)
    annotation (Line(points={{-27.86619206369884,-230.0120680945563},{-27.86619206369884,-210.01206809455618},{-27.86619206369884,-190.01206809455618},{-27.86619206369884,-170.01206809455618},{-27.86619206369884,-150.01206809455618},{-27.86619206369884,-130.01206809455618},{-27.86619206369884,-110.01206809455618},{-27.86619206369884,-90.01206809455618},{-27.86619206369884,-70.01206809455618},{-27.86619206369884,-50.012068094556184},{-27.86619206369884,-30.012068094556184},{-27.86619206369884,-10.012068094556184},{-27.86619206369884,9.987931905443816},{-27.86619206369884,29.987931905443816},{-27.86619206369884,49.987931905443816},{-27.86619206369884,69.98793190544382},{-27.86619206369884,89.98793190544382},{-27.86619206369884,109.98793190544382},{-27.86619206369884,129.98793190544382},{-27.86619206369884,149.98793190544382},{-27.86619206369884,169.98793190544382},{-27.86619206369884,189.98793190544382},{-27.86619206369884,209.98793190544382},{-27.86619206369884,229.98793190544382},{-27.86619206369884,249.98793190544382},{-27.86619206369884,269.9879319054438},{-27.86619206369884,289.9879319054438},{-27.86619206369884,309.98793190544376},{-27.86619206369884,329.98793190544376},{-27.86619206369884,349.98793190544376},{-27.86619206369884,369.98793190544376},{-27.86619206369884,389.98793190544376},{-27.86619206369884,409.98793190544376},{-27.86619206369884,429.98793190544376},{-27.86619206369884,449.98793190544376},{-27.86619206369884,469.98793190544376},{-27.86619206369884,489.98793190544376},{-27.86619206369884,509.98793190544376},{-27.86619206369884,529.9879319054437},{-27.86619206369884,549.9879319054437},{-27.86619206369884,569.9879319054437},{-27.86619206369884,589.9879319054437},{-27.86619206369884,609.9879319054437},{-27.86619206369884,629.9879319054437},{-27.86619206369884,649.9879319054437},{-27.86619206369884,669.9879319054437},{-27.86619206369884,689.9879319054437},{-27.86619206369884,709.9879319054437},{-27.86619206369884,729.9879319054437},{-47.86619206369884,729.9879319054437},{-47.86619206369884,749.9879319054437},{-67.86619206369883,749.9879319054437}},color={0,0,127}));

  //
  // End Connect Statements for fca5ffe1
  //



  //
  // Begin Connect Statements for 7c5d908d
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_b9d7c0fd.ports_bChiWat[1], cooInd_5a3d0cc9.port_a2)
    annotation (Line(points={{45.76521060929224,786.1630932147772},{25.76521060929224,786.1630932147772}},color={0,0,127}));
  connect(cooInd_5a3d0cc9.port_b2,TimeSerLoa_b9d7c0fd.ports_aChiWat[1])
    annotation (Line(points={{40.999572302698,786.7803986380475},{60.999572302698,786.7803986380475}},color={0,0,127}));
  connect(pressure_source_7c5d908d.ports[1], cooInd_5a3d0cc9.port_b2)
    annotation (Line(points={{18.588455139403095,-234.78118159333303},{-1.411544860596905,-234.78118159333303},{-1.411544860596905,-214.78118159333303},{-1.411544860596905,-194.78118159333292},{-1.411544860596905,-174.78118159333292},{-1.411544860596905,-154.78118159333292},{-1.411544860596905,-134.78118159333292},{-1.411544860596905,-114.78118159333292},{-1.411544860596905,-94.78118159333292},{-1.411544860596905,-74.78118159333292},{-1.411544860596905,-54.78118159333292},{-1.411544860596905,-34.78118159333292},{-1.411544860596905,-14.781181593332917},{-1.411544860596905,5.218818406667083},{-1.411544860596905,25.218818406667083},{-1.411544860596905,45.21881840666708},{-1.411544860596905,65.21881840666708},{-1.411544860596905,85.21881840666708},{-1.411544860596905,105.21881840666708},{-1.411544860596905,125.21881840666708},{-1.411544860596905,145.21881840666708},{-1.411544860596905,165.21881840666708},{-1.411544860596905,185.21881840666708},{-1.411544860596905,205.21881840666708},{-1.411544860596905,225.21881840666708},{-1.411544860596905,245.21881840666708},{-1.411544860596905,265.2188184066671},{-1.411544860596905,285.2188184066671},{-1.411544860596905,305.2188184066671},{-1.411544860596905,325.2188184066671},{-1.411544860596905,345.2188184066671},{-1.411544860596905,365.2188184066671},{-1.411544860596905,385.2188184066671},{-1.411544860596905,405.2188184066671},{-1.411544860596905,425.2188184066671},{-1.411544860596905,445.2188184066671},{-1.411544860596905,465.2188184066671},{-1.411544860596905,485.2188184066671},{-1.411544860596905,505.2188184066671},{-1.411544860596905,525.2188184066671},{-1.411544860596905,545.2188184066671},{-1.411544860596905,565.2188184066671},{-1.411544860596905,585.2188184066671},{-1.411544860596905,605.2188184066671},{-1.411544860596905,625.2188184066671},{-1.411544860596905,645.2188184066671},{-1.411544860596905,665.2188184066671},{-1.411544860596905,685.2188184066671},{-1.411544860596905,705.2188184066671},{-1.411544860596905,725.2188184066671},{-1.411544860596905,745.2188184066671},{-1.411544860596905,765.2188184066671},{-1.411544860596905,785.2188184066671},{18.588455139403095,785.2188184066671}},color={0,0,127}));
  connect(TChiWatSet_7c5d908d.y,cooInd_5a3d0cc9.TSetBuiSup)
    annotation (Line(points={{65.2237248433766,-239.90717185278527},{65.2237248433766,-219.90717185278527},{65.2237248433766,-199.90717185278527},{45.2237248433766,-199.90717185278527},{45.2237248433766,-179.90717185278527},{45.2237248433766,-159.90717185278527},{45.2237248433766,-139.90717185278527},{45.2237248433766,-119.90717185278527},{45.2237248433766,-99.90717185278527},{45.2237248433766,-79.90717185278527},{45.2237248433766,-59.90717185278527},{45.2237248433766,-39.90717185278527},{45.2237248433766,-19.907171852785268},{45.2237248433766,0.09282814721473187},{45.2237248433766,20.092828147214732},{45.2237248433766,40.09282814721473},{45.2237248433766,60.09282814721473},{45.2237248433766,80.09282814721473},{45.2237248433766,100.09282814721473},{45.2237248433766,120.09282814721473},{45.2237248433766,140.09282814721473},{45.2237248433766,160.09282814721473},{45.2237248433766,180.09282814721473},{45.2237248433766,200.09282814721473},{45.2237248433766,220.09282814721473},{45.2237248433766,240.09282814721473},{45.2237248433766,260.09282814721473},{45.2237248433766,280.09282814721473},{45.2237248433766,300.0928281472148},{45.2237248433766,320.0928281472148},{45.2237248433766,340.0928281472148},{45.2237248433766,360.0928281472148},{45.2237248433766,380.0928281472148},{45.2237248433766,400.0928281472148},{45.2237248433766,420.0928281472148},{45.2237248433766,440.0928281472148},{45.2237248433766,460.0928281472148},{45.2237248433766,480.0928281472148},{45.2237248433766,500.0928281472148},{45.2237248433766,520.0928281472147},{45.2237248433766,540.0928281472147},{45.2237248433766,560.0928281472147},{45.2237248433766,580.0928281472147},{45.2237248433766,600.0928281472147},{45.2237248433766,620.0928281472147},{45.2237248433766,640.0928281472147},{45.2237248433766,660.0928281472147},{45.2237248433766,680.0928281472147},{45.2237248433766,700.0928281472147},{45.2237248433766,720.0928281472147},{45.2237248433766,740.0928281472147},{45.2237248433766,760.0928281472147},{45.2237248433766,780.0928281472147},{65.2237248433766,780.0928281472147}},color={0,0,127}));

  //
  // End Connect Statements for 7c5d908d
  //



  //
  // Begin Connect Statements for 5b3030bb
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[1],cooInd_5a3d0cc9.port_a1)
    annotation (Line(points={{7.8592516392002665,780.8939028642149},{27.859251639200266,780.8939028642149}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[1],cooInd_5a3d0cc9.port_b1)
    annotation (Line(points={{-7.712157852809483,779.1502279244353},{12.287842147190517,779.1502279244353}},color={0,0,127}));

  //
  // End Connect Statements for 5b3030bb
  //



  //
  // Begin Connect Statements for 18fc0592
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_b9d7c0fd.ports_bHeaWat[1], heaInd_ad7a3c5b.port_a2)
    annotation (Line(points={{57.659278381382535,755.2915404091834},{57.659278381382535,735.2915404091834},{37.65927838138252,735.2915404091834},{17.65927838138252,735.2915404091834}},color={0,0,127}));
  connect(heaInd_ad7a3c5b.port_b2,TimeSerLoa_b9d7c0fd.ports_aHeaWat[1])
    annotation (Line(points={{16.647736783761644,761.892590883169},{36.647736783761644,761.892590883169},{36.647736783761644,781.892590883169},{56.647736783761644,781.892590883169}},color={0,0,127}));
  connect(pressure_source_18fc0592.ports[1], heaInd_ad7a3c5b.port_b2)
    annotation (Line(points={{-51.868701697102566,-289.13482255753433},{-31.868701697102566,-289.13482255753433},{-31.868701697102566,-269.13482255753433},{-31.868701697102566,-249.13482255753433},{-31.868701697102566,-229.13482255753433},{-31.868701697102566,-209.13482255753422},{-31.868701697102566,-189.13482255753422},{-31.868701697102566,-169.13482255753422},{-31.868701697102566,-149.13482255753422},{-31.868701697102566,-129.13482255753422},{-31.868701697102566,-109.13482255753422},{-31.868701697102566,-89.13482255753422},{-31.868701697102566,-69.13482255753422},{-31.868701697102566,-49.13482255753422},{-31.868701697102566,-29.13482255753422},{-31.868701697102566,-9.134822557534221},{-31.868701697102566,10.865177442465779},{-31.868701697102566,30.86517744246578},{-31.868701697102566,50.86517744246578},{-31.868701697102566,70.86517744246578},{-31.868701697102566,90.86517744246578},{-31.868701697102566,110.86517744246578},{-31.868701697102566,130.86517744246578},{-31.868701697102566,150.86517744246578},{-31.868701697102566,170.86517744246578},{-31.868701697102566,190.86517744246578},{-31.868701697102566,210.86517744246578},{-31.868701697102566,230.86517744246578},{-31.868701697102566,250.86517744246578},{-31.868701697102566,270.8651774424658},{-31.868701697102566,290.8651774424658},{-31.868701697102566,310.8651774424658},{-31.868701697102566,330.8651774424658},{-31.868701697102566,350.8651774424658},{-31.868701697102566,370.8651774424658},{-31.868701697102566,390.8651774424658},{-31.868701697102566,410.8651774424658},{-31.868701697102566,430.8651774424658},{-31.868701697102566,450.8651774424658},{-31.868701697102566,470.8651774424658},{-31.868701697102566,490.8651774424658},{-31.868701697102566,510.8651774424658},{-31.868701697102566,530.8651774424658},{-31.868701697102566,550.8651774424658},{-31.868701697102566,570.8651774424658},{-31.868701697102566,590.8651774424658},{-31.868701697102566,610.8651774424658},{-31.868701697102566,630.8651774424658},{-31.868701697102566,650.8651774424658},{-31.868701697102566,670.8651774424658},{-31.868701697102566,690.8651774424658},{-31.868701697102566,710.8651774424658},{-11.868701697102566,710.8651774424658},{8.131298302897434,710.8651774424658},{8.131298302897434,730.8651774424658},{28.131298302897434,730.8651774424658}},color={0,0,127}));
  connect(THeaWatSet_18fc0592.y,heaInd_ad7a3c5b.TSetBuiSup)
    annotation (Line(points={{-28.912505291440745,-281.52803573930146},{-8.912505291440752,-281.52803573930146},{-8.912505291440752,-261.52803573930146},{-8.912505291440752,-241.52803573930146},{-8.912505291440752,-221.52803573930146},{-8.912505291440752,-201.52803573930146},{-8.912505291440752,-181.52803573930146},{-8.912505291440752,-161.52803573930146},{-8.912505291440752,-141.52803573930146},{-8.912505291440752,-121.52803573930146},{-8.912505291440752,-101.52803573930146},{-8.912505291440752,-81.52803573930146},{-8.912505291440752,-61.52803573930146},{-8.912505291440752,-41.52803573930146},{-8.912505291440752,-21.52803573930146},{-8.912505291440752,-1.5280357393014583},{-8.912505291440752,18.47196426069854},{-8.912505291440752,38.47196426069854},{-8.912505291440752,58.47196426069854},{-8.912505291440752,78.47196426069854},{-8.912505291440752,98.47196426069854},{-8.912505291440752,118.47196426069854},{-8.912505291440752,138.47196426069854},{-8.912505291440752,158.47196426069854},{-8.912505291440752,178.47196426069854},{-8.912505291440752,198.47196426069854},{-8.912505291440752,218.47196426069854},{-8.912505291440752,238.47196426069854},{-8.912505291440752,258.47196426069854},{-8.912505291440752,278.47196426069854},{-8.912505291440752,298.47196426069854},{-8.912505291440752,318.47196426069854},{-8.912505291440752,338.47196426069854},{-8.912505291440752,358.47196426069854},{-8.912505291440752,378.47196426069854},{-8.912505291440752,398.47196426069854},{-8.912505291440752,418.47196426069854},{-8.912505291440752,438.47196426069854},{-8.912505291440752,458.47196426069854},{-8.912505291440752,478.47196426069854},{-8.912505291440752,498.47196426069854},{-8.912505291440752,518.4719642606985},{-8.912505291440752,538.4719642606985},{-8.912505291440752,558.4719642606985},{-8.912505291440752,578.4719642606985},{-8.912505291440752,598.4719642606985},{-8.912505291440752,618.4719642606985},{-8.912505291440752,638.4719642606985},{-8.912505291440752,658.4719642606985},{-8.912505291440752,678.4719642606985},{-8.912505291440752,698.4719642606985},{-8.912505291440752,718.4719642606985},{-8.912505291440752,738.4719642606985},{11.087494708559248,738.4719642606985}},color={0,0,127}));

  //
  // End Connect Statements for 18fc0592
  //



  //
  // Begin Connect Statements for 8de55549
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[1],heaInd_ad7a3c5b.port_a1)
    annotation (Line(points={{8.622851288735774,737.0689239447896},{28.622851288735774,737.0689239447896}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[1],heaInd_ad7a3c5b.port_b1)
    annotation (Line(points={{-1.142483621714291,737.700413522591},{18.85751637828571,737.700413522591}},color={0,0,127}));

  //
  // End Connect Statements for 8de55549
  //



  //
  // Begin Connect Statements for e5175857
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_d42aed2f.ports_bChiWat[1], cooInd_b433d2ec.port_a2)
    annotation (Line(points={{32.646044980536644,693.096119891814},{12.646044980536644,693.096119891814}},color={0,0,127}));
  connect(cooInd_b433d2ec.port_b2,TimeSerLoa_d42aed2f.ports_aChiWat[1])
    annotation (Line(points={{43.9392037598673,691.3099068648365},{63.9392037598673,691.3099068648365}},color={0,0,127}));
  connect(pressure_source_e5175857.ports[1], cooInd_b433d2ec.port_b2)
    annotation (Line(points={{26.065454475145458,-287.9396293830696},{6.065454475145458,-287.9396293830696},{6.065454475145458,-267.9396293830696},{6.065454475145458,-247.9396293830696},{6.065454475145458,-227.9396293830696},{6.065454475145458,-207.93962938306947},{6.065454475145458,-187.93962938306947},{6.065454475145458,-167.93962938306947},{6.065454475145458,-147.93962938306947},{6.065454475145458,-127.93962938306947},{6.065454475145458,-107.93962938306947},{6.065454475145458,-87.93962938306947},{6.065454475145458,-67.93962938306947},{6.065454475145458,-47.93962938306947},{6.065454475145458,-27.939629383069473},{6.065454475145458,-7.939629383069473},{6.065454475145458,12.060370616930527},{6.065454475145458,32.06037061693053},{6.065454475145458,52.06037061693053},{6.065454475145458,72.06037061693053},{6.065454475145458,92.06037061693053},{6.065454475145458,112.06037061693053},{6.065454475145458,132.06037061693053},{6.065454475145458,152.06037061693053},{6.065454475145458,172.06037061693053},{6.065454475145458,192.06037061693053},{6.065454475145458,212.06037061693053},{6.065454475145458,232.06037061693053},{6.065454475145458,252.06037061693053},{6.065454475145458,272.0603706169305},{6.065454475145458,292.0603706169305},{6.065454475145458,312.06037061693047},{6.065454475145458,332.06037061693047},{6.065454475145458,352.06037061693047},{6.065454475145458,372.06037061693047},{6.065454475145458,392.06037061693047},{6.065454475145458,412.06037061693047},{6.065454475145458,432.06037061693047},{6.065454475145458,452.06037061693047},{6.065454475145458,472.06037061693047},{6.065454475145458,492.06037061693047},{6.065454475145458,512.0603706169304},{6.065454475145458,532.0603706169304},{6.065454475145458,552.0603706169304},{6.065454475145458,572.0603706169305},{6.065454475145458,592.0603706169305},{6.065454475145458,612.0603706169305},{6.065454475145458,632.0603706169305},{6.065454475145458,652.0603706169305},{6.065454475145458,672.0603706169305},{6.065454475145458,692.0603706169305},{26.065454475145458,692.0603706169305}},color={0,0,127}));
  connect(TChiWatSet_e5175857.y,cooInd_b433d2ec.TSetBuiSup)
    annotation (Line(points={{53.839788194718295,-273.8412141039705},{33.839788194718295,-273.8412141039705},{33.839788194718295,-253.84121410397051},{33.839788194718295,-233.84121410397051},{33.839788194718295,-213.84121410397051},{33.839788194718295,-193.84121410397051},{33.839788194718295,-173.84121410397051},{33.839788194718295,-153.84121410397051},{33.839788194718295,-133.84121410397051},{33.839788194718295,-113.84121410397051},{33.839788194718295,-93.84121410397051},{33.839788194718295,-73.84121410397051},{33.839788194718295,-53.841214103970515},{33.839788194718295,-33.841214103970515},{33.839788194718295,-13.841214103970515},{33.839788194718295,6.158785896029485},{33.839788194718295,26.158785896029485},{33.839788194718295,46.158785896029485},{33.839788194718295,66.15878589602949},{33.839788194718295,86.15878589602949},{33.839788194718295,106.15878589602949},{33.839788194718295,126.15878589602949},{33.839788194718295,146.15878589602949},{33.839788194718295,166.15878589602949},{33.839788194718295,186.15878589602949},{33.839788194718295,206.15878589602949},{33.839788194718295,226.15878589602949},{33.839788194718295,246.15878589602949},{33.839788194718295,266.1587858960295},{33.839788194718295,286.1587858960295},{33.839788194718295,306.1587858960295},{33.839788194718295,326.1587858960295},{33.839788194718295,346.1587858960295},{33.839788194718295,366.1587858960295},{33.839788194718295,386.1587858960295},{33.839788194718295,406.1587858960295},{33.839788194718295,426.1587858960295},{33.839788194718295,446.1587858960295},{33.839788194718295,466.1587858960295},{33.839788194718295,486.1587858960295},{33.839788194718295,506.1587858960295},{33.839788194718295,526.1587858960295},{33.839788194718295,546.1587858960295},{33.839788194718295,566.1587858960295},{33.839788194718295,586.1587858960295},{33.839788194718295,606.1587858960295},{33.839788194718295,626.1587858960295},{33.839788194718295,646.1587858960295},{33.839788194718295,666.1587858960295},{33.839788194718295,686.1587858960295},{33.839788194718295,706.1587858960295},{53.839788194718295,706.1587858960295}},color={0,0,127}));

  //
  // End Connect Statements for e5175857
  //



  //
  // Begin Connect Statements for 0805f439
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[2],cooInd_b433d2ec.port_a1)
    annotation (Line(points={{-23.863387239358786,754.1306505240988},{-3.8633872393587865,754.1306505240988},{-3.8633872393587865,734.1306505240988},{-3.8633872393587865,714.1306505240988},{-3.8633872393587865,694.1306505240988},{16.136612760641214,694.1306505240988}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[2],cooInd_b433d2ec.port_b1)
    annotation (Line(points={{-27.476225512489194,760.2270479738748},{-7.476225512489194,760.2270479738748},{-7.476225512489194,740.2270479738748},{-7.476225512489194,720.2270479738748},{-7.476225512489194,700.2270479738748},{12.523774487510806,700.2270479738748}},color={0,0,127}));

  //
  // End Connect Statements for 0805f439
  //



  //
  // Begin Connect Statements for 901e3563
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_d42aed2f.ports_bHeaWat[1], heaInd_5f113052.port_a2)
    annotation (Line(points={{56.92025687221525,679.7066464956899},{56.92025687221525,659.7066464956899},{36.92025687221525,659.7066464956899},{16.920256872215248,659.7066464956899}},color={0,0,127}));
  connect(heaInd_5f113052.port_b2,TimeSerLoa_d42aed2f.ports_aHeaWat[1])
    annotation (Line(points={{26.77505714400519,671.767396245396},{46.77505714400519,671.767396245396},{46.77505714400519,691.767396245396},{66.77505714400519,691.767396245396}},color={0,0,127}));
  connect(pressure_source_901e3563.ports[1], heaInd_5f113052.port_b2)
    annotation (Line(points={{-64.25775614994467,-313.8082025454994},{-44.25775614994467,-313.8082025454994},{-44.25775614994467,-293.8082025454994},{-44.25775614994467,-273.8082025454994},{-44.25775614994467,-253.8082025454994},{-44.25775614994467,-233.8082025454994},{-44.25775614994467,-213.80820254549928},{-44.25775614994467,-193.80820254549928},{-44.25775614994467,-173.80820254549928},{-44.25775614994467,-153.80820254549928},{-44.25775614994467,-133.80820254549928},{-44.25775614994467,-113.80820254549928},{-44.25775614994467,-93.80820254549928},{-44.25775614994467,-73.80820254549928},{-44.25775614994467,-53.808202545499284},{-44.25775614994467,-33.808202545499284},{-44.25775614994467,-13.808202545499284},{-44.25775614994467,6.1917974545007155},{-44.25775614994467,26.191797454500716},{-44.25775614994467,46.191797454500716},{-44.25775614994467,66.19179745450072},{-44.25775614994467,86.19179745450072},{-44.25775614994467,106.19179745450072},{-44.25775614994467,126.19179745450072},{-44.25775614994467,146.19179745450072},{-44.25775614994467,166.19179745450072},{-44.25775614994467,186.19179745450072},{-44.25775614994467,206.19179745450072},{-44.25775614994467,226.19179745450072},{-44.25775614994467,246.19179745450072},{-44.25775614994467,266.1917974545007},{-44.25775614994467,286.1917974545007},{-44.25775614994467,306.1917974545007},{-44.25775614994467,326.1917974545007},{-44.25775614994467,346.1917974545007},{-44.25775614994467,366.1917974545007},{-44.25775614994467,386.1917974545007},{-44.25775614994467,406.1917974545007},{-44.25775614994467,426.1917974545007},{-44.25775614994467,446.1917974545007},{-44.25775614994467,466.1917974545007},{-44.25775614994467,486.1917974545007},{-44.25775614994467,506.1917974545007},{-44.25775614994467,526.1917974545007},{-44.25775614994467,546.1917974545007},{-44.25775614994467,566.1917974545007},{-44.25775614994467,586.1917974545007},{-44.25775614994467,606.1917974545007},{-44.25775614994467,626.1917974545007},{-44.25775614994467,646.1917974545007},{-44.25775614994467,666.1917974545007},{-24.25775614994467,666.1917974545007},{-4.257756149944669,666.1917974545007},{15.742243850055331,666.1917974545007}},color={0,0,127}));
  connect(THeaWatSet_901e3563.y,heaInd_5f113052.TSetBuiSup)
    annotation (Line(points={{-12.366018966104406,-317.50483324503807},{7.633981033895594,-317.50483324503807},{7.633981033895594,-297.50483324503807},{7.633981033895594,-277.50483324503807},{7.633981033895594,-257.50483324503807},{7.633981033895594,-237.50483324503807},{7.633981033895594,-217.50483324503807},{7.633981033895594,-197.50483324503807},{7.633981033895594,-177.50483324503807},{7.633981033895594,-157.50483324503807},{7.633981033895594,-137.50483324503807},{7.633981033895594,-117.50483324503807},{7.633981033895594,-97.50483324503807},{7.633981033895594,-77.50483324503807},{7.633981033895594,-57.50483324503807},{7.633981033895594,-37.50483324503807},{7.633981033895594,-17.50483324503807},{7.633981033895594,2.4951667549619287},{7.633981033895594,22.49516675496193},{7.633981033895594,42.49516675496193},{7.633981033895594,62.49516675496193},{7.633981033895594,82.49516675496193},{7.633981033895594,102.49516675496193},{7.633981033895594,122.49516675496193},{7.633981033895594,142.49516675496193},{7.633981033895594,162.49516675496193},{7.633981033895594,182.49516675496193},{7.633981033895594,202.49516675496193},{7.633981033895594,222.49516675496193},{7.633981033895594,242.49516675496193},{7.633981033895594,262.49516675496193},{7.633981033895594,282.49516675496193},{7.633981033895594,302.4951667549619},{7.633981033895594,322.4951667549619},{7.633981033895594,342.4951667549619},{7.633981033895594,362.4951667549619},{7.633981033895594,382.4951667549619},{7.633981033895594,402.4951667549619},{7.633981033895594,422.4951667549619},{7.633981033895594,442.4951667549619},{7.633981033895594,462.4951667549619},{7.633981033895594,482.4951667549619},{7.633981033895594,502.4951667549619},{7.633981033895594,522.4951667549619},{7.633981033895594,542.4951667549619},{7.633981033895594,562.4951667549619},{7.633981033895594,582.4951667549619},{7.633981033895594,602.4951667549619},{7.633981033895594,622.4951667549619},{7.633981033895594,642.4951667549619},{7.633981033895594,662.4951667549619},{27.633981033895594,662.4951667549619}},color={0,0,127}));

  //
  // End Connect Statements for 901e3563
  //



  //
  // Begin Connect Statements for 916e5d56
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[2],heaInd_5f113052.port_a1)
    annotation (Line(points={{-11.597025972959557,717.8420220866433},{-11.597025972959557,697.8420220866433},{-11.597025972959557,677.8420220866433},{-11.597025972959557,657.8420220866433},{8.402974027040443,657.8420220866433},{28.402974027040443,657.8420220866433}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[2],heaInd_5f113052.port_b1)
    annotation (Line(points={{-22.750422456313288,724.5589091354584},{-22.750422456313288,704.5589091354584},{-22.750422456313288,684.5589091354584},{-22.750422456313288,664.5589091354584},{-2.750422456313288,664.5589091354584},{17.249577543686712,664.5589091354584}},color={0,0,127}));

  //
  // End Connect Statements for 916e5d56
  //



  //
  // Begin Connect Statements for 4a226a2a
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_6ad3533e.ports_bChiWat[1], cooInd_71df9072.port_a2)
    annotation (Line(points={{39.35634339039126,622.8655186674755},{19.35634339039126,622.8655186674755}},color={0,0,127}));
  connect(cooInd_71df9072.port_b2,TimeSerLoa_6ad3533e.ports_aChiWat[1])
    annotation (Line(points={{45.41556744699244,613.3945468859905},{65.41556744699244,613.3945468859905}},color={0,0,127}));
  connect(pressure_source_4a226a2a.ports[1], cooInd_71df9072.port_b2)
    annotation (Line(points={{25.577146530539153,-329.6293006600554},{5.577146530539153,-329.6293006600554},{5.577146530539153,-309.6293006600554},{5.577146530539153,-289.6293006600554},{5.577146530539153,-269.6293006600554},{5.577146530539153,-249.62930066005538},{5.577146530539153,-229.62930066005538},{5.577146530539153,-209.62930066005538},{5.577146530539153,-189.62930066005538},{5.577146530539153,-169.62930066005538},{5.577146530539153,-149.62930066005538},{5.577146530539153,-129.62930066005538},{5.577146530539153,-109.62930066005538},{5.577146530539153,-89.62930066005538},{5.577146530539153,-69.62930066005538},{5.577146530539153,-49.62930066005538},{5.577146530539153,-29.629300660055378},{5.577146530539153,-9.629300660055378},{5.577146530539153,10.370699339944622},{5.577146530539153,30.370699339944622},{5.577146530539153,50.37069933994462},{5.577146530539153,70.37069933994462},{5.577146530539153,90.37069933994462},{5.577146530539153,110.37069933994462},{5.577146530539153,130.37069933994462},{5.577146530539153,150.37069933994462},{5.577146530539153,170.37069933994462},{5.577146530539153,190.37069933994462},{5.577146530539153,210.37069933994462},{5.577146530539153,230.37069933994462},{5.577146530539153,250.37069933994462},{5.577146530539153,270.3706993399446},{5.577146530539153,290.3706993399446},{5.577146530539153,310.3706993399446},{5.577146530539153,330.3706993399446},{5.577146530539153,350.3706993399446},{5.577146530539153,370.3706993399446},{5.577146530539153,390.3706993399446},{5.577146530539153,410.3706993399446},{5.577146530539153,430.3706993399446},{5.577146530539153,450.3706993399446},{5.577146530539153,470.3706993399446},{5.577146530539153,490.3706993399446},{5.577146530539153,510.3706993399446},{5.577146530539153,530.3706993399446},{5.577146530539153,550.3706993399446},{5.577146530539153,570.3706993399446},{5.577146530539153,590.3706993399446},{5.577146530539153,610.3706993399446},{25.577146530539153,610.3706993399446}},color={0,0,127}));
  connect(TChiWatSet_4a226a2a.y,cooInd_71df9072.TSetBuiSup)
    annotation (Line(points={{64.0364847902749,-324.0509119384526},{44.0364847902749,-324.0509119384526},{44.0364847902749,-304.0509119384526},{44.0364847902749,-284.0509119384526},{44.0364847902749,-264.0509119384526},{44.0364847902749,-244.0509119384526},{44.0364847902749,-224.0509119384526},{44.0364847902749,-204.0509119384526},{44.0364847902749,-184.0509119384526},{44.0364847902749,-164.0509119384526},{44.0364847902749,-144.0509119384526},{44.0364847902749,-124.0509119384526},{44.0364847902749,-104.0509119384526},{44.0364847902749,-84.0509119384526},{44.0364847902749,-64.0509119384526},{44.0364847902749,-44.0509119384526},{44.0364847902749,-24.0509119384526},{44.0364847902749,-4.0509119384526},{44.0364847902749,15.9490880615474},{44.0364847902749,35.9490880615474},{44.0364847902749,55.9490880615474},{44.0364847902749,75.9490880615474},{44.0364847902749,95.9490880615474},{44.0364847902749,115.9490880615474},{44.0364847902749,135.9490880615474},{44.0364847902749,155.9490880615474},{44.0364847902749,175.9490880615474},{44.0364847902749,195.9490880615474},{44.0364847902749,215.9490880615474},{44.0364847902749,235.9490880615474},{44.0364847902749,255.9490880615474},{44.0364847902749,275.9490880615474},{44.0364847902749,295.9490880615474},{44.0364847902749,315.94908806154734},{44.0364847902749,335.94908806154734},{44.0364847902749,355.94908806154734},{44.0364847902749,375.94908806154734},{44.0364847902749,395.94908806154734},{44.0364847902749,415.94908806154734},{44.0364847902749,435.94908806154734},{44.0364847902749,455.94908806154734},{44.0364847902749,475.94908806154734},{44.0364847902749,495.94908806154734},{44.0364847902749,515.9490880615474},{44.0364847902749,535.9490880615474},{44.0364847902749,555.9490880615474},{44.0364847902749,575.9490880615474},{44.0364847902749,595.9490880615474},{44.0364847902749,615.9490880615474},{64.0364847902749,615.9490880615474}},color={0,0,127}));

  //
  // End Connect Statements for 4a226a2a
  //



  //
  // Begin Connect Statements for 078a1b5f
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[3],cooInd_71df9072.port_a1)
    annotation (Line(points={{-26.99663435632705,763.8773614788478},{-6.99663435632705,763.8773614788478},{-6.99663435632705,743.8773614788478},{-6.99663435632705,723.8773614788478},{-6.99663435632705,703.8773614788478},{-6.99663435632705,683.8773614788478},{-6.99663435632705,663.8773614788478},{-6.99663435632705,643.8773614788478},{-6.99663435632705,623.8773614788478},{13.00336564367295,623.8773614788478}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[3],cooInd_71df9072.port_b1)
    annotation (Line(points={{-21.44440917044598,759.6658523836941},{-1.4444091704459794,759.6658523836941},{-1.4444091704459794,739.6658523836941},{-1.4444091704459794,719.6658523836941},{-1.4444091704459794,699.6658523836941},{-1.4444091704459794,679.6658523836941},{-1.4444091704459794,659.6658523836941},{-1.4444091704459794,639.6658523836941},{-1.4444091704459794,619.6658523836941},{18.55559082955402,619.6658523836941}},color={0,0,127}));

  //
  // End Connect Statements for 078a1b5f
  //



  //
  // Begin Connect Statements for 823fe32b
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_6ad3533e.ports_bHeaWat[1], heaInd_aebed689.port_a2)
    annotation (Line(points={{55.86306084111632,599.7666740025635},{55.86306084111632,579.7666740025635},{35.86306084111631,579.7666740025635},{15.863060841116308,579.7666740025635}},color={0,0,127}));
  connect(heaInd_aebed689.port_b2,TimeSerLoa_6ad3533e.ports_aHeaWat[1])
    annotation (Line(points={{18.34116504753372,606.7732987254902},{38.34116504753371,606.7732987254902},{38.34116504753371,626.7732987254902},{58.34116504753371,626.7732987254902}},color={0,0,127}));
  connect(pressure_source_823fe32b.ports[1], heaInd_aebed689.port_b2)
    annotation (Line(points={{-66.54627073324185,-360.0153723376634},{-46.546270733241855,-360.0153723376634},{-46.546270733241855,-340.0153723376634},{-46.546270733241855,-320.0153723376634},{-46.546270733241855,-300.0153723376634},{-46.546270733241855,-280.0153723376634},{-46.546270733241855,-260.0153723376634},{-46.546270733241855,-240.0153723376634},{-46.546270733241855,-220.0153723376634},{-46.546270733241855,-200.0153723376635},{-46.546270733241855,-180.0153723376635},{-46.546270733241855,-160.0153723376635},{-46.546270733241855,-140.0153723376635},{-46.546270733241855,-120.0153723376635},{-46.546270733241855,-100.0153723376635},{-46.546270733241855,-80.0153723376635},{-46.546270733241855,-60.01537233766351},{-46.546270733241855,-40.01537233766351},{-46.546270733241855,-20.015372337663507},{-46.546270733241855,-0.015372337663507096},{-46.546270733241855,19.984627662336493},{-46.546270733241855,39.98462766233649},{-46.546270733241855,59.98462766233649},{-46.546270733241855,79.9846276623365},{-46.546270733241855,99.9846276623365},{-46.546270733241855,119.9846276623365},{-46.546270733241855,139.9846276623365},{-46.546270733241855,159.9846276623365},{-46.546270733241855,179.9846276623365},{-46.546270733241855,199.9846276623365},{-46.546270733241855,219.9846276623365},{-46.546270733241855,239.9846276623365},{-46.546270733241855,259.9846276623365},{-46.546270733241855,279.9846276623365},{-46.546270733241855,299.98462766233655},{-46.546270733241855,319.98462766233655},{-46.546270733241855,339.98462766233655},{-46.546270733241855,359.98462766233655},{-46.546270733241855,379.98462766233655},{-46.546270733241855,399.98462766233655},{-46.546270733241855,419.98462766233655},{-46.546270733241855,439.98462766233655},{-46.546270733241855,459.98462766233655},{-46.546270733241855,479.98462766233655},{-46.546270733241855,499.98462766233655},{-46.546270733241855,519.9846276623366},{-46.546270733241855,539.9846276623366},{-46.546270733241855,559.9846276623365},{-46.546270733241855,579.9846276623365},{-26.546270733241855,579.9846276623365},{-6.546270733241855,579.9846276623365},{13.453729266758145,579.9846276623365}},color={0,0,127}));
  connect(THeaWatSet_823fe32b.y,heaInd_aebed689.TSetBuiSup)
    annotation (Line(points={{-24.666254601252604,-369.3677466957238},{-4.666254601252604,-369.3677466957238},{-4.666254601252604,-349.3677466957238},{-4.666254601252604,-329.3677466957238},{-4.666254601252604,-309.3677466957238},{-4.666254601252604,-289.3677466957238},{-4.666254601252604,-269.3677466957238},{-4.666254601252604,-249.36774669572378},{-4.666254601252604,-229.36774669572378},{-4.666254601252604,-209.36774669572367},{-4.666254601252604,-189.36774669572367},{-4.666254601252604,-169.36774669572367},{-4.666254601252604,-149.36774669572367},{-4.666254601252604,-129.36774669572367},{-4.666254601252604,-109.36774669572367},{-4.666254601252604,-89.36774669572367},{-4.666254601252604,-69.36774669572367},{-4.666254601252604,-49.36774669572367},{-4.666254601252604,-29.367746695723667},{-4.666254601252604,-9.367746695723667},{-4.666254601252604,10.632253304276333},{-4.666254601252604,30.632253304276333},{-4.666254601252604,50.63225330427633},{-4.666254601252604,70.63225330427633},{-4.666254601252604,90.63225330427633},{-4.666254601252604,110.63225330427633},{-4.666254601252604,130.63225330427633},{-4.666254601252604,150.63225330427633},{-4.666254601252604,170.63225330427633},{-4.666254601252604,190.63225330427633},{-4.666254601252604,210.63225330427633},{-4.666254601252604,230.63225330427633},{-4.666254601252604,250.63225330427633},{-4.666254601252604,270.63225330427633},{-4.666254601252604,290.63225330427633},{-4.666254601252604,310.63225330427633},{-4.666254601252604,330.63225330427633},{-4.666254601252604,350.63225330427633},{-4.666254601252604,370.63225330427633},{-4.666254601252604,390.63225330427633},{-4.666254601252604,410.63225330427633},{-4.666254601252604,430.63225330427633},{-4.666254601252604,450.63225330427633},{-4.666254601252604,470.63225330427633},{-4.666254601252604,490.63225330427633},{-4.666254601252604,510.63225330427633},{-4.666254601252604,530.6322533042763},{-4.666254601252604,550.6322533042763},{-4.666254601252604,570.6322533042763},{15.333745398747396,570.6322533042763}},color={0,0,127}));

  //
  // End Connect Statements for 823fe32b
  //



  //
  // Begin Connect Statements for 23bb2127
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[3],heaInd_aebed689.port_a1)
    annotation (Line(points={{-18.461048760128406,723.5255255312178},{-18.461048760128406,703.5255255312178},{-18.461048760128406,683.5255255312178},{-18.461048760128406,663.5255255312178},{-18.461048760128406,643.5255255312178},{-18.461048760128406,623.5255255312178},{-18.461048760128406,603.5255255312178},{-18.461048760128406,583.5255255312178},{1.5389512398715937,583.5255255312178},{21.538951239871594,583.5255255312178}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[3],heaInd_aebed689.port_b1)
    annotation (Line(points={{-28.55273429188547,722.8457544207581},{-28.55273429188547,702.8457544207581},{-28.55273429188547,682.8457544207581},{-28.55273429188547,662.8457544207581},{-28.55273429188547,642.8457544207581},{-28.55273429188547,622.8457544207581},{-28.55273429188547,602.8457544207581},{-28.55273429188547,582.8457544207581},{-8.552734291885471,582.8457544207581},{11.447265708114529,582.8457544207581}},color={0,0,127}));

  //
  // End Connect Statements for 23bb2127
  //



  //
  // Begin Connect Statements for 258db06f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_3faa3aa6.ports_bChiWat[1], cooInd_e21a2366.port_a2)
    annotation (Line(points={{65.12673032016065,510.859411598756},{65.12673032016065,490.859411598756},{45.12673032016065,490.859411598756},{25.126730320160647,490.859411598756}},color={0,0,127}));
  connect(cooInd_e21a2366.port_b2,TimeSerLoa_3faa3aa6.ports_aChiWat[1])
    annotation (Line(points={{24.883042845440045,526.0471292477678},{44.88304284544003,526.0471292477678},{44.88304284544003,546.0471292477678},{64.88304284544003,546.0471292477678}},color={0,0,127}));
  connect(pressure_source_258db06f.ports[1], cooInd_e21a2366.port_b2)
    annotation (Line(points={{23.656174524207046,-369.6815744122432},{3.656174524207046,-369.6815744122432},{3.656174524207046,-349.6815744122432},{3.656174524207046,-329.6815744122432},{3.656174524207046,-309.6815744122432},{3.656174524207046,-289.6815744122432},{3.656174524207046,-269.6815744122432},{3.656174524207046,-249.6815744122432},{3.656174524207046,-229.6815744122432},{3.656174524207046,-209.6815744122431},{3.656174524207046,-189.6815744122431},{3.656174524207046,-169.6815744122431},{3.656174524207046,-149.6815744122431},{3.656174524207046,-129.6815744122431},{3.656174524207046,-109.6815744122431},{3.656174524207046,-89.6815744122431},{3.656174524207046,-69.6815744122431},{3.656174524207046,-49.681574412243094},{3.656174524207046,-29.681574412243094},{3.656174524207046,-9.681574412243094},{3.656174524207046,10.318425587756906},{3.656174524207046,30.318425587756906},{3.656174524207046,50.318425587756906},{3.656174524207046,70.3184255877569},{3.656174524207046,90.3184255877569},{3.656174524207046,110.3184255877569},{3.656174524207046,130.3184255877569},{3.656174524207046,150.3184255877569},{3.656174524207046,170.3184255877569},{3.656174524207046,190.3184255877569},{3.656174524207046,210.3184255877569},{3.656174524207046,230.3184255877569},{3.656174524207046,250.3184255877569},{3.656174524207046,270.3184255877569},{3.656174524207046,290.3184255877569},{3.656174524207046,310.3184255877569},{3.656174524207046,330.3184255877569},{3.656174524207046,350.3184255877569},{3.656174524207046,370.3184255877569},{3.656174524207046,390.3184255877569},{3.656174524207046,410.3184255877569},{3.656174524207046,430.3184255877569},{3.656174524207046,450.3184255877569},{3.656174524207046,470.3184255877569},{3.656174524207046,490.3184255877569},{23.656174524207046,490.3184255877569}},color={0,0,127}));
  connect(TChiWatSet_258db06f.y,cooInd_e21a2366.TSetBuiSup)
    annotation (Line(points={{63.21953344136472,-366.71485259723727},{43.21953344136472,-366.71485259723727},{43.21953344136472,-346.71485259723727},{43.21953344136472,-326.71485259723727},{43.21953344136472,-306.71485259723727},{43.21953344136472,-286.71485259723727},{43.21953344136472,-266.71485259723727},{43.21953344136472,-246.71485259723727},{43.21953344136472,-226.71485259723727},{43.21953344136472,-206.71485259723727},{43.21953344136472,-186.71485259723727},{43.21953344136472,-166.71485259723727},{43.21953344136472,-146.71485259723727},{43.21953344136472,-126.71485259723727},{43.21953344136472,-106.71485259723727},{43.21953344136472,-86.71485259723727},{43.21953344136472,-66.71485259723727},{43.21953344136472,-46.71485259723727},{43.21953344136472,-26.714852597237268},{43.21953344136472,-6.714852597237268},{43.21953344136472,13.285147402762732},{43.21953344136472,33.28514740276273},{43.21953344136472,53.28514740276273},{43.21953344136472,73.28514740276273},{43.21953344136472,93.28514740276273},{43.21953344136472,113.28514740276273},{43.21953344136472,133.28514740276273},{43.21953344136472,153.28514740276273},{43.21953344136472,173.28514740276273},{43.21953344136472,193.28514740276273},{43.21953344136472,213.28514740276273},{43.21953344136472,233.28514740276273},{43.21953344136472,253.28514740276273},{43.21953344136472,273.28514740276273},{43.21953344136472,293.28514740276273},{43.21953344136472,313.2851474027627},{43.21953344136472,333.2851474027627},{43.21953344136472,353.2851474027627},{43.21953344136472,373.2851474027627},{43.21953344136472,393.2851474027627},{43.21953344136472,413.2851474027627},{43.21953344136472,433.2851474027627},{43.21953344136472,453.2851474027627},{43.21953344136472,473.2851474027627},{43.21953344136472,493.2851474027627},{43.21953344136472,513.2851474027627},{43.21953344136472,533.2851474027627},{63.21953344136472,533.2851474027627}},color={0,0,127}));

  //
  // End Connect Statements for 258db06f
  //



  //
  // Begin Connect Statements for c8432462
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[4],cooInd_e21a2366.port_a1)
    annotation (Line(points={{-22.400085579717285,759.3802137880907},{-2.4000855797172846,759.3802137880907},{-2.4000855797172846,739.3802137880907},{-2.4000855797172846,719.3802137880907},{-2.4000855797172846,699.3802137880907},{-2.4000855797172846,679.3802137880907},{-2.4000855797172846,659.3802137880907},{-2.4000855797172846,639.3802137880907},{-2.4000855797172846,619.3802137880907},{-2.4000855797172846,599.3802137880907},{-2.4000855797172846,579.3802137880907},{-2.4000855797172846,559.3802137880907},{-2.4000855797172846,539.3802137880907},{-2.4000855797172846,519.3802137880907},{-2.4000855797172846,499.3802137880907},{17.599914420282715,499.3802137880907}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[4],cooInd_e21a2366.port_b1)
    annotation (Line(points={{-20.874611223127232,756.7814454924928},{-0.874611223127232,756.7814454924928},{-0.874611223127232,736.7814454924928},{-0.874611223127232,716.7814454924928},{-0.874611223127232,696.7814454924928},{-0.874611223127232,676.7814454924928},{-0.874611223127232,656.7814454924928},{-0.874611223127232,636.7814454924928},{-0.874611223127232,616.7814454924928},{-0.874611223127232,596.7814454924928},{-0.874611223127232,576.7814454924928},{-0.874611223127232,556.7814454924928},{-0.874611223127232,536.7814454924928},{-0.874611223127232,516.7814454924928},{-0.874611223127232,496.7814454924928},{19.125388776872768,496.7814454924928}},color={0,0,127}));

  //
  // End Connect Statements for c8432462
  //



  //
  // Begin Connect Statements for 7b472f1e
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_3faa3aa6.ports_bHeaWat[1], heaInd_1a6adde7.port_a2)
    annotation (Line(points={{31.095678975963963,530.4548720150209},{11.095678975963963,530.4548720150209}},color={0,0,127}));
  connect(heaInd_1a6adde7.port_b2,TimeSerLoa_3faa3aa6.ports_aHeaWat[1])
    annotation (Line(points={{36.32471299383518,546.623896249952},{56.32471299383516,546.623896249952}},color={0,0,127}));
  connect(pressure_source_7b472f1e.ports[1], heaInd_1a6adde7.port_b2)
    annotation (Line(points={{-65.03300005568246,-393.05253248437157},{-45.03300005568246,-393.05253248437157},{-45.03300005568246,-373.05253248437157},{-45.03300005568246,-353.05253248437157},{-45.03300005568246,-333.05253248437157},{-45.03300005568246,-313.05253248437157},{-45.03300005568246,-293.05253248437157},{-45.03300005568246,-273.05253248437157},{-45.03300005568246,-253.05253248437157},{-45.03300005568246,-233.05253248437157},{-45.03300005568246,-213.05253248437157},{-45.03300005568246,-193.05253248437157},{-45.03300005568246,-173.05253248437157},{-45.03300005568246,-153.05253248437157},{-45.03300005568246,-133.05253248437157},{-45.03300005568246,-113.05253248437157},{-45.03300005568246,-93.05253248437157},{-45.03300005568246,-73.05253248437157},{-45.03300005568246,-53.05253248437157},{-45.03300005568246,-33.05253248437157},{-45.03300005568246,-13.052532484371568},{-45.03300005568246,6.947467515628432},{-45.03300005568246,26.947467515628432},{-45.03300005568246,46.94746751562843},{-45.03300005568246,66.94746751562843},{-45.03300005568246,86.94746751562843},{-45.03300005568246,106.94746751562843},{-45.03300005568246,126.94746751562843},{-45.03300005568246,146.94746751562843},{-45.03300005568246,166.94746751562843},{-45.03300005568246,186.94746751562843},{-45.03300005568246,206.94746751562843},{-45.03300005568246,226.94746751562843},{-45.03300005568246,246.94746751562843},{-45.03300005568246,266.94746751562843},{-45.03300005568246,286.94746751562843},{-45.03300005568246,306.9474675156285},{-45.03300005568246,326.9474675156285},{-45.03300005568246,346.9474675156285},{-45.03300005568246,366.9474675156285},{-45.03300005568246,386.9474675156285},{-45.03300005568246,406.9474675156285},{-45.03300005568246,426.9474675156285},{-45.03300005568246,446.9474675156285},{-45.03300005568246,466.9474675156285},{-45.03300005568246,486.9474675156285},{-45.03300005568246,506.9474675156285},{-45.03300005568246,526.9474675156284},{-45.03300005568246,546.9474675156284},{-25.033000055682464,546.9474675156284},{-5.033000055682464,546.9474675156284},{14.966999944317536,546.9474675156284}},color={0,0,127}));
  connect(THeaWatSet_7b472f1e.y,heaInd_1a6adde7.TSetBuiSup)
    annotation (Line(points={{-15.217576695597657,-402.63888699525137},{4.782423304402343,-402.63888699525137},{4.782423304402343,-382.63888699525137},{4.782423304402343,-362.63888699525137},{4.782423304402343,-342.63888699525137},{4.782423304402343,-322.63888699525137},{4.782423304402343,-302.63888699525137},{4.782423304402343,-282.63888699525137},{4.782423304402343,-262.63888699525137},{4.782423304402343,-242.63888699525137},{4.782423304402343,-222.63888699525137},{4.782423304402343,-202.63888699525137},{4.782423304402343,-182.63888699525137},{4.782423304402343,-162.63888699525137},{4.782423304402343,-142.63888699525137},{4.782423304402343,-122.63888699525137},{4.782423304402343,-102.63888699525137},{4.782423304402343,-82.63888699525137},{4.782423304402343,-62.63888699525137},{4.782423304402343,-42.63888699525137},{4.782423304402343,-22.63888699525137},{4.782423304402343,-2.6388869952513687},{4.782423304402343,17.36111300474863},{4.782423304402343,37.36111300474863},{4.782423304402343,57.36111300474863},{4.782423304402343,77.36111300474863},{4.782423304402343,97.36111300474863},{4.782423304402343,117.36111300474863},{4.782423304402343,137.36111300474863},{4.782423304402343,157.36111300474863},{4.782423304402343,177.36111300474863},{4.782423304402343,197.36111300474863},{4.782423304402343,217.36111300474863},{4.782423304402343,237.36111300474863},{4.782423304402343,257.36111300474863},{4.782423304402343,277.36111300474863},{4.782423304402343,297.36111300474863},{4.782423304402343,317.36111300474863},{4.782423304402343,337.36111300474863},{4.782423304402343,357.36111300474863},{4.782423304402343,377.36111300474863},{4.782423304402343,397.36111300474863},{4.782423304402343,417.36111300474863},{4.782423304402343,437.36111300474863},{4.782423304402343,457.36111300474863},{4.782423304402343,477.36111300474863},{4.782423304402343,497.36111300474863},{4.782423304402343,517.3611130047486},{4.782423304402343,537.3611130047486},{24.782423304402343,537.3611130047486}},color={0,0,127}));

  //
  // End Connect Statements for 7b472f1e
  //



  //
  // Begin Connect Statements for f45ff8f7
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[4],heaInd_1a6adde7.port_a1)
    annotation (Line(points={{-16.872254215393767,728.1228717793362},{-16.872254215393767,708.1228717793362},{-16.872254215393767,688.1228717793362},{-16.872254215393767,668.1228717793362},{-16.872254215393767,648.1228717793362},{-16.872254215393767,628.1228717793362},{-16.872254215393767,608.1228717793362},{-16.872254215393767,588.1228717793362},{-16.872254215393767,568.1228717793362},{-16.872254215393767,548.122871779336},{3.1277457846062333,548.122871779336},{23.127745784606233,548.122871779336}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[4],heaInd_1a6adde7.port_b1)
    annotation (Line(points={{-28.628926695757997,720.2185865253709},{-28.628926695757997,700.2185865253709},{-28.628926695757997,680.2185865253709},{-28.628926695757997,660.2185865253709},{-28.628926695757997,640.2185865253709},{-28.628926695757997,620.2185865253709},{-28.628926695757997,600.2185865253709},{-28.628926695757997,580.2185865253709},{-28.628926695757997,560.2185865253709},{-28.628926695757997,540.2185865253709},{-8.628926695757997,540.2185865253709},{11.371073304242003,540.2185865253709}},color={0,0,127}));

  //
  // End Connect Statements for f45ff8f7
  //



  //
  // Begin Connect Statements for a3934b5d
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_4c7e5c88.ports_bChiWat[1], cooInd_dbcdcad2.port_a2)
    annotation (Line(points={{40.221823234422345,455.8548030668702},{20.22182323442233,455.8548030668702}},color={0,0,127}));
  connect(cooInd_dbcdcad2.port_b2,TimeSerLoa_4c7e5c88.ports_aChiWat[1])
    annotation (Line(points={{49.561869106965986,461.02581129913324},{69.56186910696599,461.02581129913324}},color={0,0,127}));
  connect(pressure_source_a3934b5d.ports[1], cooInd_dbcdcad2.port_b2)
    annotation (Line(points={{12.32879285862866,-396.1459948112338},{-7.67120714137134,-396.1459948112338},{-7.67120714137134,-376.1459948112338},{-7.67120714137134,-356.1459948112338},{-7.67120714137134,-336.1459948112338},{-7.67120714137134,-316.1459948112338},{-7.67120714137134,-296.1459948112338},{-7.67120714137134,-276.1459948112338},{-7.67120714137134,-256.1459948112338},{-7.67120714137134,-236.14599481123378},{-7.67120714137134,-216.14599481123378},{-7.67120714137134,-196.14599481123378},{-7.67120714137134,-176.14599481123378},{-7.67120714137134,-156.14599481123378},{-7.67120714137134,-136.14599481123378},{-7.67120714137134,-116.14599481123378},{-7.67120714137134,-96.14599481123378},{-7.67120714137134,-76.14599481123378},{-7.67120714137134,-56.14599481123378},{-7.67120714137134,-36.14599481123378},{-7.67120714137134,-16.145994811233777},{-7.67120714137134,3.854005188766223},{-7.67120714137134,23.854005188766223},{-7.67120714137134,43.85400518876622},{-7.67120714137134,63.85400518876622},{-7.67120714137134,83.85400518876622},{-7.67120714137134,103.85400518876622},{-7.67120714137134,123.85400518876622},{-7.67120714137134,143.85400518876622},{-7.67120714137134,163.85400518876622},{-7.67120714137134,183.85400518876622},{-7.67120714137134,203.85400518876622},{-7.67120714137134,223.85400518876622},{-7.67120714137134,243.85400518876622},{-7.67120714137134,263.8540051887662},{-7.67120714137134,283.8540051887662},{-7.67120714137134,303.8540051887662},{-7.67120714137134,323.8540051887662},{-7.67120714137134,343.8540051887662},{-7.67120714137134,363.8540051887662},{-7.67120714137134,383.8540051887662},{-7.67120714137134,403.8540051887662},{-7.67120714137134,423.8540051887662},{-7.67120714137134,443.8540051887662},{-7.67120714137134,463.8540051887662},{12.32879285862866,463.8540051887662}},color={0,0,127}));
  connect(TChiWatSet_a3934b5d.y,cooInd_dbcdcad2.TSetBuiSup)
    annotation (Line(points={{51.29094493855618,-404.96626158444406},{31.290944938556194,-404.96626158444406},{31.290944938556194,-384.96626158444406},{31.290944938556194,-364.96626158444406},{31.290944938556194,-344.96626158444406},{31.290944938556194,-324.96626158444406},{31.290944938556194,-304.96626158444406},{31.290944938556194,-284.96626158444406},{31.290944938556194,-264.96626158444406},{31.290944938556194,-244.96626158444406},{31.290944938556194,-224.96626158444406},{31.290944938556194,-204.96626158444394},{31.290944938556194,-184.96626158444394},{31.290944938556194,-164.96626158444394},{31.290944938556194,-144.96626158444394},{31.290944938556194,-124.96626158444394},{31.290944938556194,-104.96626158444394},{31.290944938556194,-84.96626158444394},{31.290944938556194,-64.96626158444394},{31.290944938556194,-44.96626158444394},{31.290944938556194,-24.96626158444394},{31.290944938556194,-4.9662615844439415},{31.290944938556194,15.033738415556058},{31.290944938556194,35.03373841555606},{31.290944938556194,55.03373841555606},{31.290944938556194,75.03373841555606},{31.290944938556194,95.03373841555606},{31.290944938556194,115.03373841555606},{31.290944938556194,135.03373841555606},{31.290944938556194,155.03373841555606},{31.290944938556194,175.03373841555606},{31.290944938556194,195.03373841555606},{31.290944938556194,215.03373841555606},{31.290944938556194,235.03373841555606},{31.290944938556194,255.03373841555606},{31.290944938556194,275.03373841555606},{31.290944938556194,295.03373841555606},{31.290944938556194,315.033738415556},{31.290944938556194,335.033738415556},{31.290944938556194,355.033738415556},{31.290944938556194,375.033738415556},{31.290944938556194,395.033738415556},{31.290944938556194,415.033738415556},{31.290944938556194,435.033738415556},{31.290944938556194,455.033738415556},{51.29094493855618,455.033738415556}},color={0,0,127}));

  //
  // End Connect Statements for a3934b5d
  //



  //
  // Begin Connect Statements for 89d7f0d0
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[5],cooInd_dbcdcad2.port_a1)
    annotation (Line(points={{-17.987677322778737,756.7380399804507},{2.0123226772212632,756.7380399804507},{2.0123226772212632,736.7380399804507},{2.0123226772212632,716.7380399804507},{2.0123226772212632,696.7380399804507},{2.0123226772212632,676.7380399804507},{2.0123226772212632,656.7380399804507},{2.0123226772212632,636.7380399804507},{2.0123226772212632,616.7380399804507},{2.0123226772212632,596.7380399804507},{2.0123226772212632,576.7380399804507},{2.0123226772212632,556.7380399804507},{2.0123226772212632,536.7380399804507},{2.0123226772212632,516.7380399804507},{2.0123226772212632,496.7380399804507},{2.0123226772212632,476.7380399804507},{2.0123226772212632,456.7380399804507},{22.012322677221263,456.7380399804507}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[5],cooInd_dbcdcad2.port_b1)
    annotation (Line(points={{-16.949658276514597,768.7174352126952},{3.0503417234854027,768.7174352126952},{3.0503417234854027,748.7174352126952},{3.0503417234854027,728.7174352126952},{3.0503417234854027,708.7174352126952},{3.0503417234854027,688.7174352126952},{3.0503417234854027,668.7174352126952},{3.0503417234854027,648.7174352126952},{3.0503417234854027,628.7174352126952},{3.0503417234854027,608.7174352126952},{3.0503417234854027,588.7174352126952},{3.0503417234854027,568.7174352126952},{3.0503417234854027,548.7174352126952},{3.0503417234854027,528.7174352126952},{3.0503417234854027,508.71743521269525},{3.0503417234854027,488.71743521269525},{3.0503417234854027,468.71743521269525},{23.050341723485403,468.71743521269525}},color={0,0,127}));

  //
  // End Connect Statements for 89d7f0d0
  //



  //
  // Begin Connect Statements for a6815496
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_4c7e5c88.ports_bHeaWat[1], heaInd_0835c310.port_a2)
    annotation (Line(points={{58.70502934943755,437.731691757317},{58.70502934943755,417.731691757317},{38.70502934943755,417.731691757317},{18.705029349437552,417.731691757317}},color={0,0,127}));
  connect(heaInd_0835c310.port_b2,TimeSerLoa_4c7e5c88.ports_aHeaWat[1])
    annotation (Line(points={{11.423243145247326,444.47020471064485},{31.423243145247326,444.47020471064485},{31.423243145247326,464.47020471064485},{51.42324314524734,464.47020471064485}},color={0,0,127}));
  connect(pressure_source_a6815496.ports[1], heaInd_0835c310.port_b2)
    annotation (Line(points={{-50.31137911500787,-430.3248217086391},{-30.311379115007867,-430.3248217086391},{-30.311379115007867,-410.3248217086391},{-30.311379115007867,-390.3248217086391},{-30.311379115007867,-370.3248217086391},{-30.311379115007867,-350.3248217086391},{-30.311379115007867,-330.3248217086391},{-30.311379115007867,-310.3248217086391},{-30.311379115007867,-290.3248217086391},{-30.311379115007867,-270.3248217086391},{-30.311379115007867,-250.3248217086391},{-30.311379115007867,-230.3248217086391},{-30.311379115007867,-210.3248217086391},{-30.311379115007867,-190.3248217086391},{-30.311379115007867,-170.3248217086391},{-30.311379115007867,-150.3248217086391},{-30.311379115007867,-130.3248217086391},{-30.311379115007867,-110.32482170863909},{-30.311379115007867,-90.32482170863909},{-30.311379115007867,-70.32482170863909},{-30.311379115007867,-50.32482170863909},{-30.311379115007867,-30.324821708639092},{-30.311379115007867,-10.324821708639092},{-30.311379115007867,9.675178291360908},{-30.311379115007867,29.675178291360908},{-30.311379115007867,49.67517829136091},{-30.311379115007867,69.67517829136091},{-30.311379115007867,89.67517829136091},{-30.311379115007867,109.67517829136091},{-30.311379115007867,129.6751782913609},{-30.311379115007867,149.6751782913609},{-30.311379115007867,169.6751782913609},{-30.311379115007867,189.6751782913609},{-30.311379115007867,209.6751782913609},{-30.311379115007867,229.6751782913609},{-30.311379115007867,249.6751782913609},{-30.311379115007867,269.6751782913609},{-30.311379115007867,289.6751782913609},{-30.311379115007867,309.6751782913609},{-30.311379115007867,329.6751782913609},{-30.311379115007867,349.6751782913609},{-30.311379115007867,369.6751782913609},{-30.311379115007867,389.6751782913609},{-30.311379115007867,409.6751782913609},{-30.311379115007867,429.6751782913609},{-10.311379115007867,429.6751782913609},{9.688620884992133,429.6751782913609},{29.688620884992133,429.6751782913609}},color={0,0,127}));
  connect(THeaWatSet_a6815496.y,heaInd_0835c310.TSetBuiSup)
    annotation (Line(points={{-16.966640339397372,-438.25059640107816},{3.0333596606026276,-438.25059640107816},{3.0333596606026276,-418.25059640107816},{3.0333596606026276,-398.25059640107816},{3.0333596606026276,-378.25059640107816},{3.0333596606026276,-358.25059640107816},{3.0333596606026276,-338.25059640107816},{3.0333596606026276,-318.25059640107816},{3.0333596606026276,-298.25059640107816},{3.0333596606026276,-278.25059640107816},{3.0333596606026276,-258.25059640107816},{3.0333596606026276,-238.25059640107816},{3.0333596606026276,-218.25059640107816},{3.0333596606026276,-198.25059640107816},{3.0333596606026276,-178.25059640107816},{3.0333596606026276,-158.25059640107816},{3.0333596606026276,-138.25059640107816},{3.0333596606026276,-118.25059640107816},{3.0333596606026276,-98.25059640107816},{3.0333596606026276,-78.25059640107816},{3.0333596606026276,-58.250596401078155},{3.0333596606026276,-38.250596401078155},{3.0333596606026276,-18.250596401078155},{3.0333596606026276,1.7494035989218446},{3.0333596606026276,21.749403598921845},{3.0333596606026276,41.749403598921845},{3.0333596606026276,61.749403598921845},{3.0333596606026276,81.74940359892184},{3.0333596606026276,101.74940359892184},{3.0333596606026276,121.74940359892184},{3.0333596606026276,141.74940359892184},{3.0333596606026276,161.74940359892184},{3.0333596606026276,181.74940359892184},{3.0333596606026276,201.74940359892184},{3.0333596606026276,221.74940359892184},{3.0333596606026276,241.74940359892184},{3.0333596606026276,261.74940359892184},{3.0333596606026276,281.74940359892184},{3.0333596606026276,301.7494035989219},{3.0333596606026276,321.7494035989219},{3.0333596606026276,341.7494035989219},{3.0333596606026276,361.7494035989219},{3.0333596606026276,381.7494035989219},{3.0333596606026276,401.7494035989219},{3.0333596606026276,421.7494035989219},{23.033359660602628,421.7494035989219}},color={0,0,127}));

  //
  // End Connect Statements for a6815496
  //



  //
  // Begin Connect Statements for b7be70c0
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[5],heaInd_0835c310.port_a1)
    annotation (Line(points={{-15.11010662381618,711.6316140719542},{-15.11010662381618,691.6316140719542},{-15.11010662381618,671.6316140719543},{-15.11010662381618,651.6316140719543},{-15.11010662381618,631.6316140719543},{-15.11010662381618,611.6316140719543},{-15.11010662381618,591.6316140719543},{-15.11010662381618,571.6316140719543},{-15.11010662381618,551.6316140719543},{-15.11010662381618,531.6316140719543},{-15.11010662381618,511.6316140719543},{-15.11010662381618,491.6316140719543},{-15.11010662381618,471.6316140719543},{-15.11010662381618,451.6316140719543},{-15.11010662381618,431.6316140719543},{-15.11010662381618,411.6316140719543},{4.889893376183821,411.6316140719543},{24.88989337618382,411.6316140719543}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[5],heaInd_0835c310.port_b1)
    annotation (Line(points={{-21.166835360846875,718.8072107852119},{-21.166835360846875,698.8072107852119},{-21.166835360846875,678.8072107852119},{-21.166835360846875,658.8072107852119},{-21.166835360846875,638.8072107852119},{-21.166835360846875,618.8072107852119},{-21.166835360846875,598.8072107852119},{-21.166835360846875,578.8072107852119},{-21.166835360846875,558.8072107852119},{-21.166835360846875,538.8072107852117},{-21.166835360846875,518.8072107852117},{-21.166835360846875,498.8072107852118},{-21.166835360846875,478.8072107852118},{-21.166835360846875,458.8072107852118},{-21.166835360846875,438.8072107852118},{-21.166835360846875,418.8072107852118},{-1.166835360846875,418.8072107852118},{18.833164639153125,418.8072107852118}},color={0,0,127}));

  //
  // End Connect Statements for b7be70c0
  //



  //
  // Begin Connect Statements for 4b8ea6e0
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_cb0bd5f5.ports_bChiWat[1], cooInd_810d4a17.port_a2)
    annotation (Line(points={{42.764165840107125,381.52341164121026},{22.76416584010711,381.52341164121026}},color={0,0,127}));
  connect(cooInd_810d4a17.port_b2,TimeSerLoa_cb0bd5f5.ports_aChiWat[1])
    annotation (Line(points={{38.728573283077736,387.50559154086056},{58.728573283077736,387.50559154086056}},color={0,0,127}));
  connect(pressure_source_4b8ea6e0.ports[1], cooInd_810d4a17.port_b2)
    annotation (Line(points={{18.72553618026197,-446.9963389292286},{-1.2744638197380311,-446.9963389292286},{-1.2744638197380311,-426.9963389292286},{-1.2744638197380311,-406.9963389292286},{-1.2744638197380311,-386.9963389292286},{-1.2744638197380311,-366.9963389292286},{-1.2744638197380311,-346.9963389292286},{-1.2744638197380311,-326.9963389292286},{-1.2744638197380311,-306.9963389292286},{-1.2744638197380311,-286.9963389292286},{-1.2744638197380311,-266.9963389292286},{-1.2744638197380311,-246.9963389292286},{-1.2744638197380311,-226.9963389292286},{-1.2744638197380311,-206.9963389292286},{-1.2744638197380311,-186.9963389292286},{-1.2744638197380311,-166.9963389292286},{-1.2744638197380311,-146.9963389292286},{-1.2744638197380311,-126.99633892922861},{-1.2744638197380311,-106.99633892922861},{-1.2744638197380311,-86.99633892922861},{-1.2744638197380311,-66.99633892922861},{-1.2744638197380311,-46.996338929228614},{-1.2744638197380311,-26.996338929228614},{-1.2744638197380311,-6.996338929228614},{-1.2744638197380311,13.003661070771386},{-1.2744638197380311,33.003661070771386},{-1.2744638197380311,53.003661070771386},{-1.2744638197380311,73.00366107077139},{-1.2744638197380311,93.00366107077139},{-1.2744638197380311,113.00366107077139},{-1.2744638197380311,133.0036610707714},{-1.2744638197380311,153.0036610707714},{-1.2744638197380311,173.0036610707714},{-1.2744638197380311,193.0036610707714},{-1.2744638197380311,213.0036610707714},{-1.2744638197380311,233.0036610707714},{-1.2744638197380311,253.0036610707714},{-1.2744638197380311,273.0036610707714},{-1.2744638197380311,293.0036610707714},{-1.2744638197380311,313.0036610707714},{-1.2744638197380311,333.0036610707714},{-1.2744638197380311,353.0036610707714},{-1.2744638197380311,373.0036610707714},{18.72553618026197,373.0036610707714}},color={0,0,127}));
  connect(TChiWatSet_4b8ea6e0.y,cooInd_810d4a17.TSetBuiSup)
    annotation (Line(points={{63.83643106385307,-449.8141385938882},{43.83643106385307,-449.8141385938882},{43.83643106385307,-429.8141385938882},{43.83643106385307,-409.8141385938882},{43.83643106385307,-389.8141385938882},{43.83643106385307,-369.8141385938882},{43.83643106385307,-349.8141385938882},{43.83643106385307,-329.8141385938882},{43.83643106385307,-309.8141385938882},{43.83643106385307,-289.8141385938882},{43.83643106385307,-269.8141385938882},{43.83643106385307,-249.81413859388817},{43.83643106385307,-229.81413859388817},{43.83643106385307,-209.81413859388806},{43.83643106385307,-189.81413859388806},{43.83643106385307,-169.81413859388806},{43.83643106385307,-149.81413859388806},{43.83643106385307,-129.81413859388806},{43.83643106385307,-109.81413859388806},{43.83643106385307,-89.81413859388806},{43.83643106385307,-69.81413859388806},{43.83643106385307,-49.81413859388806},{43.83643106385307,-29.81413859388806},{43.83643106385307,-9.81413859388806},{43.83643106385307,10.18586140611194},{43.83643106385307,30.18586140611194},{43.83643106385307,50.18586140611194},{43.83643106385307,70.18586140611194},{43.83643106385307,90.18586140611194},{43.83643106385307,110.18586140611194},{43.83643106385307,130.18586140611194},{43.83643106385307,150.18586140611194},{43.83643106385307,170.18586140611194},{43.83643106385307,190.18586140611194},{43.83643106385307,210.18586140611194},{43.83643106385307,230.18586140611194},{43.83643106385307,250.18586140611194},{43.83643106385307,270.18586140611194},{43.83643106385307,290.18586140611194},{43.83643106385307,310.18586140611194},{43.83643106385307,330.18586140611194},{43.83643106385307,350.18586140611194},{43.83643106385307,370.18586140611194},{63.83643106385307,370.18586140611194}},color={0,0,127}));

  //
  // End Connect Statements for 4b8ea6e0
  //



  //
  // Begin Connect Statements for 05d7d371
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[6],cooInd_810d4a17.port_a1)
    annotation (Line(points={{-12.045279416263725,758.2738083011614},{7.954720583736275,758.2738083011614},{7.954720583736275,738.2738083011614},{7.954720583736275,718.2738083011614},{7.954720583736275,698.2738083011614},{7.954720583736275,678.2738083011614},{7.954720583736275,658.2738083011614},{7.954720583736275,638.2738083011614},{7.954720583736275,618.2738083011614},{7.954720583736275,598.2738083011614},{7.954720583736275,578.2738083011614},{7.954720583736275,558.2738083011614},{7.954720583736275,538.2738083011614},{7.954720583736275,518.2738083011614},{7.954720583736275,498.27380830116135},{7.954720583736275,478.27380830116135},{7.954720583736275,458.27380830116135},{7.954720583736275,438.27380830116135},{7.954720583736275,418.27380830116135},{7.954720583736275,398.27380830116135},{7.954720583736275,378.27380830116135},{27.954720583736275,378.27380830116135}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[6],cooInd_810d4a17.port_b1)
    annotation (Line(points={{-18.055029086706398,750.1681741350347},{1.9449709132936022,750.1681741350347},{1.9449709132936022,730.1681741350347},{1.9449709132936022,710.1681741350347},{1.9449709132936022,690.1681741350347},{1.9449709132936022,670.1681741350347},{1.9449709132936022,650.1681741350347},{1.9449709132936022,630.1681741350347},{1.9449709132936022,610.1681741350347},{1.9449709132936022,590.1681741350347},{1.9449709132936022,570.1681741350347},{1.9449709132936022,550.1681741350347},{1.9449709132936022,530.1681741350347},{1.9449709132936022,510.16817413503475},{1.9449709132936022,490.16817413503475},{1.9449709132936022,470.16817413503475},{1.9449709132936022,450.16817413503475},{1.9449709132936022,430.16817413503475},{1.9449709132936022,410.16817413503475},{1.9449709132936022,390.16817413503475},{1.9449709132936022,370.16817413503475},{21.944970913293602,370.16817413503475}},color={0,0,127}));

  //
  // End Connect Statements for 05d7d371
  //



  //
  // Begin Connect Statements for e87e0fc3
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_cb0bd5f5.ports_bHeaWat[1], heaInd_2599e700.port_a2)
    annotation (Line(points={{51.16560736827708,368.4163982944992},{51.16560736827708,348.4163982944992},{31.16560736827708,348.4163982944992},{11.16560736827708,348.4163982944992}},color={0,0,127}));
  connect(heaInd_2599e700.port_b2,TimeSerLoa_cb0bd5f5.ports_aHeaWat[1])
    annotation (Line(points={{15.110696730394721,368.31452777694926},{35.11069673039472,368.31452777694926},{35.11069673039472,388.31452777694926},{55.11069673039472,388.31452777694926}},color={0,0,127}));
  connect(pressure_source_e87e0fc3.ports[1], heaInd_2599e700.port_b2)
    annotation (Line(points={{-58.28384258985129,-488.57422760300483},{-38.28384258985129,-488.57422760300483},{-38.28384258985129,-468.57422760300483},{-38.28384258985129,-448.57422760300483},{-38.28384258985129,-428.57422760300483},{-38.28384258985129,-408.57422760300483},{-38.28384258985129,-388.57422760300483},{-38.28384258985129,-368.57422760300483},{-38.28384258985129,-348.57422760300483},{-38.28384258985129,-328.57422760300483},{-38.28384258985129,-308.57422760300483},{-38.28384258985129,-288.57422760300483},{-38.28384258985129,-268.57422760300483},{-38.28384258985129,-248.57422760300483},{-38.28384258985129,-228.57422760300483},{-38.28384258985129,-208.57422760300472},{-38.28384258985129,-188.57422760300472},{-38.28384258985129,-168.57422760300472},{-38.28384258985129,-148.57422760300472},{-38.28384258985129,-128.57422760300472},{-38.28384258985129,-108.57422760300472},{-38.28384258985129,-88.57422760300472},{-38.28384258985129,-68.57422760300472},{-38.28384258985129,-48.574227603004715},{-38.28384258985129,-28.574227603004715},{-38.28384258985129,-8.574227603004715},{-38.28384258985129,11.425772396995285},{-38.28384258985129,31.425772396995285},{-38.28384258985129,51.425772396995285},{-38.28384258985129,71.42577239699528},{-38.28384258985129,91.42577239699528},{-38.28384258985129,111.42577239699528},{-38.28384258985129,131.42577239699528},{-38.28384258985129,151.42577239699528},{-38.28384258985129,171.42577239699528},{-38.28384258985129,191.42577239699528},{-38.28384258985129,211.42577239699528},{-38.28384258985129,231.42577239699528},{-38.28384258985129,251.42577239699528},{-38.28384258985129,271.4257723969953},{-38.28384258985129,291.4257723969953},{-38.28384258985129,311.4257723969953},{-38.28384258985129,331.4257723969953},{-18.28384258985129,331.4257723969953},{1.7161574101487105,331.4257723969953},{21.71615741014871,331.4257723969953}},color={0,0,127}));
  connect(THeaWatSet_e87e0fc3.y,heaInd_2599e700.TSetBuiSup)
    annotation (Line(points={{-22.469912651710985,-485.89188237532517},{-2.4699126517109846,-485.89188237532517},{-2.4699126517109846,-465.89188237532517},{-2.4699126517109846,-445.89188237532517},{-2.4699126517109846,-425.89188237532517},{-2.4699126517109846,-405.89188237532517},{-2.4699126517109846,-385.89188237532517},{-2.4699126517109846,-365.89188237532517},{-2.4699126517109846,-345.89188237532517},{-2.4699126517109846,-325.89188237532517},{-2.4699126517109846,-305.89188237532517},{-2.4699126517109846,-285.89188237532517},{-2.4699126517109846,-265.89188237532517},{-2.4699126517109846,-245.89188237532517},{-2.4699126517109846,-225.89188237532517},{-2.4699126517109846,-205.89188237532517},{-2.4699126517109846,-185.89188237532517},{-2.4699126517109846,-165.89188237532517},{-2.4699126517109846,-145.89188237532517},{-2.4699126517109846,-125.89188237532517},{-2.4699126517109846,-105.89188237532517},{-2.4699126517109846,-85.89188237532517},{-2.4699126517109846,-65.89188237532517},{-2.4699126517109846,-45.89188237532517},{-2.4699126517109846,-25.891882375325167},{-2.4699126517109846,-5.891882375325167},{-2.4699126517109846,14.108117624674833},{-2.4699126517109846,34.10811762467483},{-2.4699126517109846,54.10811762467483},{-2.4699126517109846,74.10811762467483},{-2.4699126517109846,94.10811762467483},{-2.4699126517109846,114.10811762467483},{-2.4699126517109846,134.10811762467483},{-2.4699126517109846,154.10811762467483},{-2.4699126517109846,174.10811762467483},{-2.4699126517109846,194.10811762467483},{-2.4699126517109846,214.10811762467483},{-2.4699126517109846,234.10811762467483},{-2.4699126517109846,254.10811762467483},{-2.4699126517109846,274.10811762467483},{-2.4699126517109846,294.10811762467483},{-2.4699126517109846,314.10811762467483},{-2.4699126517109846,334.10811762467483},{17.530087348289015,334.10811762467483}},color={0,0,127}));

  //
  // End Connect Statements for e87e0fc3
  //



  //
  // Begin Connect Statements for 07c22e2c
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[6],heaInd_2599e700.port_a1)
    annotation (Line(points={{-21.21433145544475,710.4576021680165},{-21.21433145544475,690.4576021680165},{-21.21433145544475,670.4576021680166},{-21.21433145544475,650.4576021680166},{-21.21433145544475,630.4576021680166},{-21.21433145544475,610.4576021680166},{-21.21433145544475,590.4576021680166},{-21.21433145544475,570.4576021680166},{-21.21433145544475,550.4576021680166},{-21.21433145544475,530.4576021680166},{-21.21433145544475,510.45760216801654},{-21.21433145544475,490.45760216801654},{-21.21433145544475,470.45760216801654},{-21.21433145544475,450.45760216801654},{-21.21433145544475,430.45760216801654},{-21.21433145544475,410.45760216801654},{-21.21433145544475,390.45760216801654},{-21.21433145544475,370.45760216801654},{-21.21433145544475,350.45760216801654},{-21.21433145544475,330.45760216801654},{-1.21433145544475,330.45760216801654},{18.78566854455525,330.45760216801654}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[6],heaInd_2599e700.port_b1)
    annotation (Line(points={{-29.277925490970205,712.9837844091637},{-29.277925490970205,692.9837844091637},{-29.277925490970205,672.9837844091637},{-29.277925490970205,652.9837844091637},{-29.277925490970205,632.9837844091637},{-29.277925490970205,612.9837844091637},{-29.277925490970205,592.9837844091637},{-29.277925490970205,572.9837844091637},{-29.277925490970205,552.9837844091637},{-29.277925490970205,532.9837844091637},{-29.277925490970205,512.9837844091637},{-29.277925490970205,492.9837844091637},{-29.277925490970205,472.9837844091637},{-29.277925490970205,452.9837844091637},{-29.277925490970205,432.9837844091637},{-29.277925490970205,412.9837844091637},{-29.277925490970205,392.9837844091637},{-29.277925490970205,372.9837844091637},{-29.277925490970205,352.9837844091637},{-29.277925490970205,332.9837844091637},{-9.277925490970205,332.9837844091637},{10.722074509029795,332.9837844091637}},color={0,0,127}));

  //
  // End Connect Statements for 07c22e2c
  //



  //
  // Begin Connect Statements for 053e7841
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_243d819e.ports_bChiWat[1], cooInd_1b3259f7.port_a2)
    annotation (Line(points={{60.74583001839849,285.889238787816},{60.74583001839849,265.889238787816},{40.74583001839849,265.889238787816},{20.745830018398493,265.889238787816}},color={0,0,127}));
  connect(cooInd_1b3259f7.port_b2,TimeSerLoa_243d819e.ports_aChiWat[1])
    annotation (Line(points={{28.46365168272507,274.29579330298316},{48.46365168272507,274.29579330298316},{48.46365168272507,294.29579330298316},{68.46365168272507,294.29579330298316}},color={0,0,127}));
  connect(pressure_source_053e7841.ports[1], cooInd_1b3259f7.port_b2)
    annotation (Line(points={{29.19975501017319,-485.41974791091616},{9.199755010173192,-485.41974791091616},{9.199755010173192,-465.41974791091616},{9.199755010173192,-445.41974791091616},{9.199755010173192,-425.41974791091616},{9.199755010173192,-405.41974791091616},{9.199755010173192,-385.41974791091616},{9.199755010173192,-365.41974791091616},{9.199755010173192,-345.41974791091616},{9.199755010173192,-325.41974791091616},{9.199755010173192,-305.41974791091616},{9.199755010173192,-285.41974791091616},{9.199755010173192,-265.41974791091616},{9.199755010173192,-245.41974791091616},{9.199755010173192,-225.41974791091616},{9.199755010173192,-205.41974791091616},{9.199755010173192,-185.41974791091616},{9.199755010173192,-165.41974791091616},{9.199755010173192,-145.41974791091616},{9.199755010173192,-125.41974791091616},{9.199755010173192,-105.41974791091616},{9.199755010173192,-85.41974791091616},{9.199755010173192,-65.41974791091616},{9.199755010173192,-45.41974791091616},{9.199755010173192,-25.419747910916158},{9.199755010173192,-5.419747910916158},{9.199755010173192,14.580252089083842},{9.199755010173192,34.58025208908384},{9.199755010173192,54.58025208908384},{9.199755010173192,74.58025208908384},{9.199755010173192,94.58025208908384},{9.199755010173192,114.58025208908384},{9.199755010173192,134.58025208908384},{9.199755010173192,154.58025208908384},{9.199755010173192,174.58025208908384},{9.199755010173192,194.58025208908384},{9.199755010173192,214.58025208908384},{9.199755010173192,234.58025208908384},{9.199755010173192,254.58025208908384},{29.19975501017319,254.58025208908384}},color={0,0,127}));
  connect(TChiWatSet_053e7841.y,cooInd_1b3259f7.TSetBuiSup)
    annotation (Line(points={{66.16349076043332,-482.4418238744879},{46.16349076043332,-482.4418238744879},{46.16349076043332,-462.4418238744879},{46.16349076043332,-442.4418238744879},{46.16349076043332,-422.4418238744879},{46.16349076043332,-402.4418238744879},{46.16349076043332,-382.4418238744879},{46.16349076043332,-362.4418238744879},{46.16349076043332,-342.4418238744879},{46.16349076043332,-322.4418238744879},{46.16349076043332,-302.4418238744879},{46.16349076043332,-282.4418238744879},{46.16349076043332,-262.4418238744879},{46.16349076043332,-242.4418238744879},{46.16349076043332,-222.4418238744879},{46.16349076043332,-202.4418238744879},{46.16349076043332,-182.4418238744879},{46.16349076043332,-162.4418238744879},{46.16349076043332,-142.4418238744879},{46.16349076043332,-122.44182387448791},{46.16349076043332,-102.44182387448791},{46.16349076043332,-82.44182387448791},{46.16349076043332,-62.44182387448791},{46.16349076043332,-42.44182387448791},{46.16349076043332,-22.44182387448791},{46.16349076043332,-2.441823874487909},{46.16349076043332,17.55817612551209},{46.16349076043332,37.55817612551209},{46.16349076043332,57.55817612551209},{46.16349076043332,77.55817612551209},{46.16349076043332,97.55817612551209},{46.16349076043332,117.55817612551209},{46.16349076043332,137.5581761255121},{46.16349076043332,157.5581761255121},{46.16349076043332,177.5581761255121},{46.16349076043332,197.5581761255121},{46.16349076043332,217.5581761255121},{46.16349076043332,237.5581761255121},{46.16349076043332,257.5581761255121},{46.16349076043332,277.5581761255121},{46.16349076043332,297.5581761255121},{66.16349076043332,297.5581761255121}},color={0,0,127}));

  //
  // End Connect Statements for 053e7841
  //



  //
  // Begin Connect Statements for b669f535
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[7],cooInd_1b3259f7.port_a1)
    annotation (Line(points={{-24.81880124244647,766.3053363717966},{-4.818801242446469,766.3053363717966},{-4.818801242446469,746.3053363717966},{-4.818801242446469,726.3053363717966},{-4.818801242446469,706.3053363717966},{-4.818801242446469,686.3053363717966},{-4.818801242446469,666.3053363717966},{-4.818801242446469,646.3053363717966},{-4.818801242446469,626.3053363717966},{-4.818801242446469,606.3053363717966},{-4.818801242446469,586.3053363717966},{-4.818801242446469,566.3053363717966},{-4.818801242446469,546.3053363717966},{-4.818801242446469,526.3053363717966},{-4.818801242446469,506.3053363717965},{-4.818801242446469,486.3053363717965},{-4.818801242446469,466.3053363717965},{-4.818801242446469,446.3053363717965},{-4.818801242446469,426.3053363717965},{-4.818801242446469,406.3053363717965},{-4.818801242446469,386.3053363717965},{-4.818801242446469,366.3053363717965},{-4.818801242446469,346.3053363717965},{-4.818801242446469,326.3053363717965},{-4.818801242446469,306.3053363717965},{-4.818801242446469,286.30533637179656},{-4.818801242446469,266.30533637179656},{15.181198757553531,266.30533637179656}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[7],cooInd_1b3259f7.port_b1)
    annotation (Line(points={{-27.312657034685778,760.7322480705184},{-7.31265703468577,760.7322480705184},{-7.31265703468577,740.7322480705184},{-7.31265703468577,720.7322480705184},{-7.31265703468577,700.7322480705184},{-7.31265703468577,680.7322480705184},{-7.31265703468577,660.7322480705184},{-7.31265703468577,640.7322480705184},{-7.31265703468577,620.7322480705184},{-7.31265703468577,600.7322480705184},{-7.31265703468577,580.7322480705184},{-7.31265703468577,560.7322480705184},{-7.31265703468577,540.7322480705184},{-7.31265703468577,520.7322480705184},{-7.31265703468577,500.7322480705184},{-7.31265703468577,480.7322480705184},{-7.31265703468577,460.7322480705184},{-7.31265703468577,440.7322480705184},{-7.31265703468577,420.7322480705184},{-7.31265703468577,400.7322480705184},{-7.31265703468577,380.7322480705184},{-7.31265703468577,360.7322480705184},{-7.31265703468577,340.7322480705184},{-7.31265703468577,320.7322480705184},{-7.31265703468577,300.7322480705184},{-7.31265703468577,280.7322480705184},{-7.31265703468577,260.7322480705184},{12.68734296531423,260.7322480705184}},color={0,0,127}));

  //
  // End Connect Statements for b669f535
  //



  //
  // Begin Connect Statements for 88d1a97b
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_243d819e.ports_bHeaWat[1], heaInd_15b8b780.port_a2)
    annotation (Line(points={{46.96169407738046,309.2395753704432},{26.96169407738047,309.2395753704432}},color={0,0,127}));
  connect(heaInd_15b8b780.port_b2,TimeSerLoa_243d819e.ports_aHeaWat[1])
    annotation (Line(points={{33.25033237502082,308.4225739131705},{53.25033237502083,308.4225739131705}},color={0,0,127}));
  connect(pressure_source_88d1a97b.ports[1], heaInd_15b8b780.port_b2)
    annotation (Line(points={{-68.81012672155589,-513.2235821942936},{-48.81012672155588,-513.2235821942936},{-48.81012672155588,-493.2235821942936},{-48.81012672155588,-473.2235821942936},{-48.81012672155588,-453.2235821942936},{-48.81012672155588,-433.2235821942936},{-48.81012672155588,-413.2235821942936},{-48.81012672155588,-393.2235821942936},{-48.81012672155588,-373.2235821942936},{-48.81012672155588,-353.2235821942936},{-48.81012672155588,-333.2235821942936},{-48.81012672155588,-313.2235821942936},{-48.81012672155588,-293.2235821942936},{-48.81012672155588,-273.2235821942936},{-48.81012672155588,-253.2235821942936},{-48.81012672155588,-233.2235821942936},{-48.81012672155588,-213.2235821942936},{-48.81012672155588,-193.2235821942936},{-48.81012672155588,-173.2235821942936},{-48.81012672155588,-153.2235821942936},{-48.81012672155588,-133.2235821942936},{-48.81012672155588,-113.22358219429361},{-48.81012672155588,-93.22358219429361},{-48.81012672155588,-73.22358219429361},{-48.81012672155588,-53.22358219429361},{-48.81012672155588,-33.22358219429361},{-48.81012672155588,-13.223582194293613},{-48.81012672155588,6.776417805706387},{-48.81012672155588,26.776417805706387},{-48.81012672155588,46.77641780570639},{-48.81012672155588,66.77641780570639},{-48.81012672155588,86.77641780570639},{-48.81012672155588,106.77641780570639},{-48.81012672155588,126.77641780570639},{-48.81012672155588,146.7764178057064},{-48.81012672155588,166.7764178057064},{-48.81012672155588,186.7764178057064},{-48.81012672155588,206.7764178057064},{-48.81012672155588,226.7764178057064},{-48.81012672155588,246.7764178057064},{-48.81012672155588,266.7764178057064},{-48.81012672155588,286.7764178057064},{-48.81012672155588,306.7764178057064},{-28.810126721555882,306.7764178057064},{-8.810126721555875,306.7764178057064},{11.189873278444125,306.7764178057064}},color={0,0,127}));
  connect(THeaWatSet_88d1a97b.y,heaInd_15b8b780.TSetBuiSup)
    annotation (Line(points={{-14.243882070497222,-524.6481990623092},{5.7561179295027785,-524.6481990623092},{5.7561179295027785,-504.64819906230923},{5.7561179295027785,-484.64819906230923},{5.7561179295027785,-464.64819906230923},{5.7561179295027785,-444.64819906230923},{5.7561179295027785,-424.64819906230923},{5.7561179295027785,-404.64819906230923},{5.7561179295027785,-384.64819906230923},{5.7561179295027785,-364.64819906230923},{5.7561179295027785,-344.64819906230923},{5.7561179295027785,-324.64819906230923},{5.7561179295027785,-304.64819906230923},{5.7561179295027785,-284.64819906230923},{5.7561179295027785,-264.64819906230923},{5.7561179295027785,-244.64819906230923},{5.7561179295027785,-224.64819906230923},{5.7561179295027785,-204.64819906230923},{5.7561179295027785,-184.64819906230923},{5.7561179295027785,-164.64819906230923},{5.7561179295027785,-144.64819906230923},{5.7561179295027785,-124.64819906230923},{5.7561179295027785,-104.64819906230923},{5.7561179295027785,-84.64819906230923},{5.7561179295027785,-64.64819906230923},{5.7561179295027785,-44.64819906230923},{5.7561179295027785,-24.64819906230923},{5.7561179295027785,-4.6481990623092315},{5.7561179295027785,15.351800937690768},{5.7561179295027785,35.35180093769077},{5.7561179295027785,55.35180093769077},{5.7561179295027785,75.35180093769077},{5.7561179295027785,95.35180093769077},{5.7561179295027785,115.35180093769077},{5.7561179295027785,135.35180093769077},{5.7561179295027785,155.35180093769077},{5.7561179295027785,175.35180093769077},{5.7561179295027785,195.35180093769077},{5.7561179295027785,215.35180093769077},{5.7561179295027785,235.35180093769077},{5.7561179295027785,255.35180093769077},{5.7561179295027785,275.35180093769077},{5.7561179295027785,295.35180093769077},{25.75611792950278,295.35180093769077}},color={0,0,127}));

  //
  // End Connect Statements for 88d1a97b
  //



  //
  // Begin Connect Statements for f7f245c6
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[7],heaInd_15b8b780.port_a1)
    annotation (Line(points={{-25.737400704203452,726.3563119135846},{-25.737400704203452,706.3563119135846},{-25.737400704203452,686.3563119135846},{-25.737400704203452,666.3563119135846},{-25.737400704203452,646.3563119135846},{-25.737400704203452,626.3563119135846},{-25.737400704203452,606.3563119135846},{-25.737400704203452,586.3563119135846},{-25.737400704203452,566.3563119135846},{-25.737400704203452,546.3563119135847},{-25.737400704203452,526.3563119135847},{-25.737400704203452,506.35631191358465},{-25.737400704203452,486.35631191358465},{-25.737400704203452,466.35631191358465},{-25.737400704203452,446.35631191358465},{-25.737400704203452,426.35631191358465},{-25.737400704203452,406.35631191358465},{-25.737400704203452,386.35631191358465},{-25.737400704203452,366.35631191358465},{-25.737400704203452,346.35631191358465},{-25.737400704203452,326.35631191358465},{-25.737400704203452,306.35631191358465},{-5.737400704203452,306.35631191358465},{14.262599295796548,306.35631191358465}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[7],heaInd_15b8b780.port_b1)
    annotation (Line(points={{-24.451416040107105,718.0152839993095},{-24.451416040107105,698.0152839993095},{-24.451416040107105,678.0152839993095},{-24.451416040107105,658.0152839993095},{-24.451416040107105,638.0152839993095},{-24.451416040107105,618.0152839993095},{-24.451416040107105,598.0152839993095},{-24.451416040107105,578.0152839993095},{-24.451416040107105,558.0152839993095},{-24.451416040107105,538.0152839993095},{-24.451416040107105,518.0152839993095},{-24.451416040107105,498.01528399930953},{-24.451416040107105,478.01528399930953},{-24.451416040107105,458.01528399930953},{-24.451416040107105,438.01528399930953},{-24.451416040107105,418.01528399930953},{-24.451416040107105,398.01528399930953},{-24.451416040107105,378.01528399930953},{-24.451416040107105,358.01528399930953},{-24.451416040107105,338.01528399930953},{-24.451416040107105,318.01528399930953},{-24.451416040107105,298.01528399930953},{-4.451416040107105,298.01528399930953},{15.548583959892895,298.01528399930953}},color={0,0,127}));

  //
  // End Connect Statements for f7f245c6
  //



  //
  // Begin Connect Statements for cb6a012f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_f54d656c.ports_bChiWat[1], cooInd_8ecb3fa6.port_a2)
    annotation (Line(points={{68.3563936636026,198.75546605408135},{68.3563936636026,178.75546605408135},{48.3563936636026,178.75546605408135},{28.356393663602603,178.75546605408135}},color={0,0,127}));
  connect(cooInd_8ecb3fa6.port_b2,TimeSerLoa_f54d656c.ports_aChiWat[1])
    annotation (Line(points={{28.287392342403777,190.55404340611472},{48.28739234240376,190.55404340611472},{48.28739234240376,210.55404340611472},{68.28739234240376,210.55404340611472}},color={0,0,127}));
  connect(pressure_source_cb6a012f.ports[1], cooInd_8ecb3fa6.port_b2)
    annotation (Line(points={{23.541249230395152,-516.6923137566905},{3.5412492303951524,-516.6923137566905},{3.5412492303951524,-496.6923137566905},{3.5412492303951524,-476.6923137566905},{3.5412492303951524,-456.6923137566905},{3.5412492303951524,-436.6923137566905},{3.5412492303951524,-416.6923137566905},{3.5412492303951524,-396.6923137566905},{3.5412492303951524,-376.6923137566905},{3.5412492303951524,-356.6923137566905},{3.5412492303951524,-336.6923137566905},{3.5412492303951524,-316.6923137566905},{3.5412492303951524,-296.6923137566905},{3.5412492303951524,-276.6923137566905},{3.5412492303951524,-256.6923137566905},{3.5412492303951524,-236.6923137566905},{3.5412492303951524,-216.6923137566905},{3.5412492303951524,-196.6923137566905},{3.5412492303951524,-176.6923137566905},{3.5412492303951524,-156.6923137566905},{3.5412492303951524,-136.6923137566905},{3.5412492303951524,-116.69231375669051},{3.5412492303951524,-96.69231375669051},{3.5412492303951524,-76.69231375669051},{3.5412492303951524,-56.69231375669051},{3.5412492303951524,-36.69231375669051},{3.5412492303951524,-16.69231375669051},{3.5412492303951524,3.3076862433094902},{3.5412492303951524,23.30768624330949},{3.5412492303951524,43.30768624330949},{3.5412492303951524,63.30768624330949},{3.5412492303951524,83.30768624330949},{3.5412492303951524,103.30768624330949},{3.5412492303951524,123.30768624330949},{3.5412492303951524,143.3076862433095},{3.5412492303951524,163.3076862433095},{3.5412492303951524,183.3076862433095},{23.541249230395152,183.3076862433095}},color={0,0,127}));
  connect(TChiWatSet_cb6a012f.y,cooInd_8ecb3fa6.TSetBuiSup)
    annotation (Line(points={{50.051707225106384,-521.4759307939185},{30.051707225106398,-521.4759307939185},{30.051707225106398,-501.47593079391845},{30.051707225106398,-481.47593079391845},{30.051707225106398,-461.47593079391845},{30.051707225106398,-441.47593079391845},{30.051707225106398,-421.47593079391845},{30.051707225106398,-401.47593079391845},{30.051707225106398,-381.47593079391845},{30.051707225106398,-361.47593079391845},{30.051707225106398,-341.47593079391845},{30.051707225106398,-321.47593079391845},{30.051707225106398,-301.47593079391845},{30.051707225106398,-281.47593079391845},{30.051707225106398,-261.47593079391845},{30.051707225106398,-241.47593079391845},{30.051707225106398,-221.47593079391845},{30.051707225106398,-201.47593079391856},{30.051707225106398,-181.47593079391856},{30.051707225106398,-161.47593079391856},{30.051707225106398,-141.47593079391856},{30.051707225106398,-121.47593079391856},{30.051707225106398,-101.47593079391856},{30.051707225106398,-81.47593079391856},{30.051707225106398,-61.475930793918565},{30.051707225106398,-41.475930793918565},{30.051707225106398,-21.475930793918565},{30.051707225106398,-1.4759307939185646},{30.051707225106398,18.524069206081435},{30.051707225106398,38.524069206081435},{30.051707225106398,58.524069206081435},{30.051707225106398,78.52406920608144},{30.051707225106398,98.52406920608144},{30.051707225106398,118.52406920608144},{30.051707225106398,138.52406920608144},{30.051707225106398,158.52406920608144},{30.051707225106398,178.52406920608144},{30.051707225106398,198.52406920608144},{30.051707225106398,218.52406920608144},{50.051707225106384,218.52406920608144}},color={0,0,127}));

  //
  // End Connect Statements for cb6a012f
  //



  //
  // Begin Connect Statements for 8526c97e
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[8],cooInd_8ecb3fa6.port_a1)
    annotation (Line(points={{-14.897772981423515,761.0349448005626},{5.102227018576485,761.0349448005626},{5.102227018576485,741.0349448005626},{5.102227018576485,721.0349448005626},{5.102227018576485,701.0349448005626},{5.102227018576485,681.0349448005626},{5.102227018576485,661.0349448005626},{5.102227018576485,641.0349448005626},{5.102227018576485,621.0349448005626},{5.102227018576485,601.0349448005626},{5.102227018576485,581.0349448005626},{5.102227018576485,561.0349448005626},{5.102227018576485,541.0349448005626},{5.102227018576485,521.0349448005626},{5.102227018576485,501.0349448005626},{5.102227018576485,481.0349448005626},{5.102227018576485,461.0349448005626},{5.102227018576485,441.0349448005626},{5.102227018576485,421.0349448005626},{5.102227018576485,401.0349448005626},{5.102227018576485,381.0349448005626},{5.102227018576485,361.0349448005626},{5.102227018576485,341.0349448005626},{5.102227018576485,321.0349448005626},{5.102227018576485,301.0349448005626},{5.102227018576485,281.0349448005626},{5.102227018576485,261.0349448005626},{5.102227018576485,241.03494480056258},{5.102227018576485,221.03494480056258},{5.102227018576485,201.03494480056258},{5.102227018576485,181.03494480056258},{25.102227018576485,181.03494480056258}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[8],cooInd_8ecb3fa6.port_b1)
    annotation (Line(points={{-28.9989688848392,763.2992332623443},{-8.9989688848392,763.2992332623443},{-8.9989688848392,743.2992332623443},{-8.9989688848392,723.2992332623443},{-8.9989688848392,703.2992332623443},{-8.9989688848392,683.2992332623443},{-8.9989688848392,663.2992332623443},{-8.9989688848392,643.2992332623443},{-8.9989688848392,623.2992332623443},{-8.9989688848392,603.2992332623443},{-8.9989688848392,583.2992332623443},{-8.9989688848392,563.2992332623443},{-8.9989688848392,543.2992332623444},{-8.9989688848392,523.2992332623444},{-8.9989688848392,503.29923326234433},{-8.9989688848392,483.29923326234433},{-8.9989688848392,463.29923326234433},{-8.9989688848392,443.29923326234433},{-8.9989688848392,423.29923326234433},{-8.9989688848392,403.29923326234433},{-8.9989688848392,383.29923326234433},{-8.9989688848392,363.29923326234433},{-8.9989688848392,343.29923326234433},{-8.9989688848392,323.29923326234433},{-8.9989688848392,303.29923326234433},{-8.9989688848392,283.2992332623443},{-8.9989688848392,263.2992332623443},{-8.9989688848392,243.29923326234427},{-8.9989688848392,223.29923326234427},{-8.9989688848392,203.29923326234427},{-8.9989688848392,183.29923326234427},{11.0010311151608,183.29923326234427}},color={0,0,127}));

  //
  // End Connect Statements for 8526c97e
  //



  //
  // Begin Connect Statements for 48a21ccd
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_f54d656c.ports_bHeaWat[1], heaInd_c6a49d9d.port_a2)
    annotation (Line(points={{43.02760649198086,229.33874015736853},{23.027606491980862,229.33874015736853}},color={0,0,127}));
  connect(heaInd_c6a49d9d.port_b2,TimeSerLoa_f54d656c.ports_aHeaWat[1])
    annotation (Line(points={{48.86996534077937,213.10341492527687},{68.86996534077937,213.10341492527687}},color={0,0,127}));
  connect(pressure_source_48a21ccd.ports[1], heaInd_c6a49d9d.port_b2)
    annotation (Line(points={{-65.47617652453081,-559.7729091198903},{-45.476176524530814,-559.7729091198903},{-45.476176524530814,-539.7729091198903},{-45.476176524530814,-519.7729091198903},{-45.476176524530814,-499.7729091198903},{-45.476176524530814,-479.7729091198903},{-45.476176524530814,-459.7729091198903},{-45.476176524530814,-439.7729091198903},{-45.476176524530814,-419.7729091198903},{-45.476176524530814,-399.7729091198903},{-45.476176524530814,-379.7729091198903},{-45.476176524530814,-359.7729091198903},{-45.476176524530814,-339.7729091198903},{-45.476176524530814,-319.7729091198903},{-45.476176524530814,-299.7729091198903},{-45.476176524530814,-279.7729091198903},{-45.476176524530814,-259.7729091198903},{-45.476176524530814,-239.7729091198903},{-45.476176524530814,-219.7729091198903},{-45.476176524530814,-199.7729091198902},{-45.476176524530814,-179.7729091198902},{-45.476176524530814,-159.7729091198902},{-45.476176524530814,-139.7729091198902},{-45.476176524530814,-119.77290911989019},{-45.476176524530814,-99.77290911989019},{-45.476176524530814,-79.77290911989019},{-45.476176524530814,-59.77290911989019},{-45.476176524530814,-39.77290911989019},{-45.476176524530814,-19.772909119890187},{-45.476176524530814,0.22709088010981304},{-45.476176524530814,20.227090880109813},{-45.476176524530814,40.22709088010981},{-45.476176524530814,60.22709088010981},{-45.476176524530814,80.22709088010981},{-45.476176524530814,100.22709088010981},{-45.476176524530814,120.22709088010981},{-45.476176524530814,140.2270908801098},{-45.476176524530814,160.2270908801098},{-45.476176524530814,180.2270908801098},{-45.476176524530814,200.2270908801098},{-45.476176524530814,220.2270908801098},{-25.476176524530814,220.2270908801098},{-5.476176524530814,220.2270908801098},{14.523823475469186,220.2270908801098}},color={0,0,127}));
  connect(THeaWatSet_48a21ccd.y,heaInd_c6a49d9d.TSetBuiSup)
    annotation (Line(points={{-28.24691671660058,-565.4132569928929},{-8.24691671660058,-565.4132569928929},{-8.24691671660058,-545.4132569928929},{-8.24691671660058,-525.4132569928929},{-8.24691671660058,-505.4132569928929},{-8.24691671660058,-485.4132569928929},{-8.24691671660058,-465.4132569928929},{-8.24691671660058,-445.4132569928929},{-8.24691671660058,-425.4132569928929},{-8.24691671660058,-405.4132569928929},{-8.24691671660058,-385.4132569928929},{-8.24691671660058,-365.4132569928929},{-8.24691671660058,-345.4132569928929},{-8.24691671660058,-325.4132569928929},{-8.24691671660058,-305.4132569928929},{-8.24691671660058,-285.4132569928929},{-8.24691671660058,-265.4132569928929},{-8.24691671660058,-245.4132569928929},{-8.24691671660058,-225.4132569928929},{-8.24691671660058,-205.4132569928929},{-8.24691671660058,-185.4132569928929},{-8.24691671660058,-165.4132569928929},{-8.24691671660058,-145.4132569928929},{-8.24691671660058,-125.41325699289291},{-8.24691671660058,-105.41325699289291},{-8.24691671660058,-85.41325699289291},{-8.24691671660058,-65.41325699289291},{-8.24691671660058,-45.41325699289291},{-8.24691671660058,-25.41325699289291},{-8.24691671660058,-5.4132569928929115},{-8.24691671660058,14.586743007107088},{-8.24691671660058,34.58674300710709},{-8.24691671660058,54.58674300710709},{-8.24691671660058,74.58674300710709},{-8.24691671660058,94.58674300710709},{-8.24691671660058,114.58674300710709},{-8.24691671660058,134.5867430071071},{-8.24691671660058,154.5867430071071},{-8.24691671660058,174.5867430071071},{-8.24691671660058,194.5867430071071},{-8.24691671660058,214.5867430071071},{11.75308328339942,214.5867430071071}},color={0,0,127}));

  //
  // End Connect Statements for 48a21ccd
  //



  //
  // Begin Connect Statements for dc22ae51
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[8],heaInd_c6a49d9d.port_a1)
    annotation (Line(points={{-28.39364214630787,721.3101652240216},{-28.39364214630787,701.3101652240216},{-28.39364214630787,681.3101652240216},{-28.39364214630787,661.3101652240216},{-28.39364214630787,641.3101652240216},{-28.39364214630787,621.3101652240216},{-28.39364214630787,601.3101652240216},{-28.39364214630787,581.3101652240216},{-28.39364214630787,561.3101652240216},{-28.39364214630787,541.3101652240216},{-28.39364214630787,521.3101652240216},{-28.39364214630787,501.31016522402166},{-28.39364214630787,481.31016522402166},{-28.39364214630787,461.31016522402166},{-28.39364214630787,441.31016522402166},{-28.39364214630787,421.31016522402166},{-28.39364214630787,401.31016522402166},{-28.39364214630787,381.31016522402166},{-28.39364214630787,361.31016522402166},{-28.39364214630787,341.31016522402166},{-28.39364214630787,321.31016522402166},{-28.39364214630787,301.31016522402166},{-28.39364214630787,281.3101652240216},{-28.39364214630787,261.3101652240216},{-28.39364214630787,241.3101652240216},{-28.39364214630787,221.3101652240216},{-8.393642146307869,221.3101652240216},{11.606357853692131,221.3101652240216}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[8],heaInd_c6a49d9d.port_b1)
    annotation (Line(points={{-27.017289691370244,711.237146139196},{-27.017289691370244,691.237146139196},{-27.017289691370244,671.237146139196},{-27.017289691370244,651.237146139196},{-27.017289691370244,631.237146139196},{-27.017289691370244,611.237146139196},{-27.017289691370244,591.237146139196},{-27.017289691370244,571.237146139196},{-27.017289691370244,551.237146139196},{-27.017289691370244,531.237146139196},{-27.017289691370244,511.23714613919606},{-27.017289691370244,491.23714613919606},{-27.017289691370244,471.23714613919606},{-27.017289691370244,451.23714613919606},{-27.017289691370244,431.23714613919606},{-27.017289691370244,411.23714613919606},{-27.017289691370244,391.23714613919606},{-27.017289691370244,371.23714613919606},{-27.017289691370244,351.23714613919606},{-27.017289691370244,331.23714613919606},{-27.017289691370244,311.23714613919606},{-27.017289691370244,291.23714613919606},{-27.017289691370244,271.23714613919606},{-27.017289691370244,251.23714613919606},{-27.017289691370244,231.23714613919606},{-27.017289691370244,211.23714613919606},{-7.017289691370237,211.23714613919606},{12.982710308629763,211.23714613919606}},color={0,0,127}));

  //
  // End Connect Statements for dc22ae51
  //



  //
  // Begin Connect Statements for c8ff26e5
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_898b2762.ports_bChiWat[1], cooInd_7511120a.port_a2)
    annotation (Line(points={{47.55359539817778,141.75067135787026},{27.55359539817779,141.75067135787026}},color={0,0,127}));
  connect(cooInd_7511120a.port_b2,TimeSerLoa_898b2762.ports_aChiWat[1])
    annotation (Line(points={{47.4258263544198,135.748985704868},{67.4258263544198,135.748985704868}},color={0,0,127}));
  connect(pressure_source_c8ff26e5.ports[1], cooInd_7511120a.port_b2)
    annotation (Line(points={{26.33968892337853,-555.8477552023169},{6.339688923378532,-555.8477552023169},{6.339688923378532,-535.8477552023169},{6.339688923378532,-515.8477552023169},{6.339688923378532,-495.8477552023169},{6.339688923378532,-475.8477552023169},{6.339688923378532,-455.8477552023169},{6.339688923378532,-435.8477552023169},{6.339688923378532,-415.8477552023169},{6.339688923378532,-395.8477552023169},{6.339688923378532,-375.8477552023169},{6.339688923378532,-355.8477552023169},{6.339688923378532,-335.8477552023169},{6.339688923378532,-315.8477552023169},{6.339688923378532,-295.8477552023169},{6.339688923378532,-275.8477552023169},{6.339688923378532,-255.84775520231688},{6.339688923378532,-235.84775520231688},{6.339688923378532,-215.84775520231688},{6.339688923378532,-195.847755202317},{6.339688923378532,-175.847755202317},{6.339688923378532,-155.847755202317},{6.339688923378532,-135.847755202317},{6.339688923378532,-115.84775520231699},{6.339688923378532,-95.84775520231699},{6.339688923378532,-75.84775520231699},{6.339688923378532,-55.84775520231699},{6.339688923378532,-35.84775520231699},{6.339688923378532,-15.84775520231699},{6.339688923378532,4.152244797683011},{6.339688923378532,24.15224479768301},{6.339688923378532,44.15224479768301},{6.339688923378532,64.15224479768301},{6.339688923378532,84.15224479768301},{6.339688923378532,104.15224479768301},{6.339688923378532,124.15224479768301},{6.339688923378532,144.152244797683},{26.33968892337853,144.152244797683}},color={0,0,127}));
  connect(TChiWatSet_c8ff26e5.y,cooInd_7511120a.TSetBuiSup)
    annotation (Line(points={{66.71593726361567,-558.9570614680442},{46.71593726361567,-558.9570614680442},{46.71593726361567,-538.9570614680442},{46.71593726361567,-518.9570614680442},{46.71593726361567,-498.95706146804423},{46.71593726361567,-478.95706146804423},{46.71593726361567,-458.95706146804423},{46.71593726361567,-438.95706146804423},{46.71593726361567,-418.95706146804423},{46.71593726361567,-398.95706146804423},{46.71593726361567,-378.95706146804423},{46.71593726361567,-358.95706146804423},{46.71593726361567,-338.95706146804423},{46.71593726361567,-318.95706146804423},{46.71593726361567,-298.95706146804423},{46.71593726361567,-278.95706146804423},{46.71593726361567,-258.95706146804423},{46.71593726361567,-238.95706146804423},{46.71593726361567,-218.95706146804423},{46.71593726361567,-198.95706146804423},{46.71593726361567,-178.95706146804423},{46.71593726361567,-158.95706146804423},{46.71593726361567,-138.95706146804423},{46.71593726361567,-118.95706146804423},{46.71593726361567,-98.95706146804423},{46.71593726361567,-78.95706146804423},{46.71593726361567,-58.95706146804423},{46.71593726361567,-38.95706146804423},{46.71593726361567,-18.95706146804423},{46.71593726361567,1.0429385319557696},{46.71593726361567,21.04293853195577},{46.71593726361567,41.04293853195577},{46.71593726361567,61.04293853195577},{46.71593726361567,81.04293853195577},{46.71593726361567,101.04293853195577},{46.71593726361567,121.04293853195577},{46.71593726361567,141.04293853195577},{66.71593726361567,141.04293853195577}},color={0,0,127}));

  //
  // End Connect Statements for c8ff26e5
  //



  //
  // Begin Connect Statements for 23f81f2b
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[9],cooInd_7511120a.port_a1)
    annotation (Line(points={{-28.53300555785519,754.5513183623557},{-8.53300555785519,754.5513183623557},{-8.53300555785519,734.5513183623557},{-8.53300555785519,714.5513183623557},{-8.53300555785519,694.5513183623557},{-8.53300555785519,674.5513183623557},{-8.53300555785519,654.5513183623557},{-8.53300555785519,634.5513183623557},{-8.53300555785519,614.5513183623557},{-8.53300555785519,594.5513183623557},{-8.53300555785519,574.5513183623557},{-8.53300555785519,554.5513183623557},{-8.53300555785519,534.5513183623557},{-8.53300555785519,514.5513183623557},{-8.53300555785519,494.5513183623557},{-8.53300555785519,474.5513183623557},{-8.53300555785519,454.5513183623557},{-8.53300555785519,434.5513183623557},{-8.53300555785519,414.5513183623557},{-8.53300555785519,394.5513183623557},{-8.53300555785519,374.5513183623557},{-8.53300555785519,354.5513183623557},{-8.53300555785519,334.5513183623557},{-8.53300555785519,314.5513183623557},{-8.53300555785519,294.5513183623557},{-8.53300555785519,274.5513183623557},{-8.53300555785519,254.5513183623557},{-8.53300555785519,234.5513183623557},{-8.53300555785519,214.5513183623557},{-8.53300555785519,194.5513183623557},{-8.53300555785519,174.5513183623557},{-8.53300555785519,154.5513183623557},{-8.53300555785519,134.5513183623557},{11.46699444214481,134.5513183623557}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[9],cooInd_7511120a.port_b1)
    annotation (Line(points={{-10.586941030557497,752.391218521263},{9.413058969442503,752.391218521263},{9.413058969442503,732.391218521263},{9.413058969442503,712.391218521263},{9.413058969442503,692.391218521263},{9.413058969442503,672.391218521263},{9.413058969442503,652.391218521263},{9.413058969442503,632.391218521263},{9.413058969442503,612.391218521263},{9.413058969442503,592.391218521263},{9.413058969442503,572.391218521263},{9.413058969442503,552.391218521263},{9.413058969442503,532.391218521263},{9.413058969442503,512.391218521263},{9.413058969442503,492.391218521263},{9.413058969442503,472.391218521263},{9.413058969442503,452.391218521263},{9.413058969442503,432.391218521263},{9.413058969442503,412.391218521263},{9.413058969442503,392.391218521263},{9.413058969442503,372.391218521263},{9.413058969442503,352.391218521263},{9.413058969442503,332.391218521263},{9.413058969442503,312.391218521263},{9.413058969442503,292.391218521263},{9.413058969442503,272.391218521263},{9.413058969442503,252.391218521263},{9.413058969442503,232.391218521263},{9.413058969442503,212.391218521263},{9.413058969442503,192.391218521263},{9.413058969442503,172.391218521263},{9.413058969442503,152.391218521263},{9.413058969442503,132.391218521263},{29.413058969442503,132.391218521263}},color={0,0,127}));

  //
  // End Connect Statements for 23f81f2b
  //



  //
  // Begin Connect Statements for 151fe7e1
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_898b2762.ports_bHeaWat[1], heaInd_6dbd67b3.port_a2)
    annotation (Line(points={{57.47507583789741,115.31928284790774},{57.47507583789741,95.31928284790774},{37.47507583789742,95.31928284790774},{17.47507583789742,95.31928284790774}},color={0,0,127}));
  connect(heaInd_6dbd67b3.port_b2,TimeSerLoa_898b2762.ports_aHeaWat[1])
    annotation (Line(points={{22.217597383777303,111.78464068694586},{42.2175973837773,111.78464068694586},{42.2175973837773,131.78464068694586},{62.2175973837773,131.78464068694586}},color={0,0,127}));
  connect(pressure_source_151fe7e1.ports[1], heaInd_6dbd67b3.port_b2)
    annotation (Line(points={{-65.38162801629927,-605.1346993780476},{-45.381628016299274,-605.1346993780476},{-45.381628016299274,-585.1346993780476},{-45.381628016299274,-565.1346993780476},{-45.381628016299274,-545.1346993780476},{-45.381628016299274,-525.1346993780476},{-45.381628016299274,-505.13469937804757},{-45.381628016299274,-485.13469937804757},{-45.381628016299274,-465.13469937804757},{-45.381628016299274,-445.13469937804757},{-45.381628016299274,-425.13469937804757},{-45.381628016299274,-405.13469937804757},{-45.381628016299274,-385.13469937804757},{-45.381628016299274,-365.13469937804757},{-45.381628016299274,-345.13469937804757},{-45.381628016299274,-325.13469937804757},{-45.381628016299274,-305.13469937804757},{-45.381628016299274,-285.13469937804757},{-45.381628016299274,-265.13469937804757},{-45.381628016299274,-245.13469937804757},{-45.381628016299274,-225.13469937804757},{-45.381628016299274,-205.13469937804769},{-45.381628016299274,-185.13469937804769},{-45.381628016299274,-165.13469937804769},{-45.381628016299274,-145.13469937804769},{-45.381628016299274,-125.13469937804769},{-45.381628016299274,-105.13469937804769},{-45.381628016299274,-85.13469937804769},{-45.381628016299274,-65.13469937804769},{-45.381628016299274,-45.134699378047685},{-45.381628016299274,-25.134699378047685},{-45.381628016299274,-5.134699378047685},{-45.381628016299274,14.865300621952315},{-45.381628016299274,34.865300621952315},{-45.381628016299274,54.865300621952315},{-45.381628016299274,74.86530062195231},{-45.381628016299274,94.86530062195231},{-25.381628016299274,94.86530062195231},{-5.381628016299274,94.86530062195231},{14.618371983700726,94.86530062195231}},color={0,0,127}));
  connect(THeaWatSet_151fe7e1.y,heaInd_6dbd67b3.TSetBuiSup)
    annotation (Line(points={{-22.830292442919372,-590.9843017410619},{-2.8302924429193723,-590.9843017410619},{-2.8302924429193723,-570.9843017410619},{-2.8302924429193723,-550.9843017410619},{-2.8302924429193723,-530.9843017410619},{-2.8302924429193723,-510.9843017410619},{-2.8302924429193723,-490.9843017410619},{-2.8302924429193723,-470.9843017410619},{-2.8302924429193723,-450.9843017410619},{-2.8302924429193723,-430.9843017410619},{-2.8302924429193723,-410.9843017410619},{-2.8302924429193723,-390.9843017410619},{-2.8302924429193723,-370.9843017410619},{-2.8302924429193723,-350.9843017410619},{-2.8302924429193723,-330.9843017410619},{-2.8302924429193723,-310.9843017410619},{-2.8302924429193723,-290.9843017410619},{-2.8302924429193723,-270.9843017410619},{-2.8302924429193723,-250.98430174106193},{-2.8302924429193723,-230.98430174106193},{-2.8302924429193723,-210.98430174106204},{-2.8302924429193723,-190.98430174106204},{-2.8302924429193723,-170.98430174106204},{-2.8302924429193723,-150.98430174106204},{-2.8302924429193723,-130.98430174106204},{-2.8302924429193723,-110.98430174106204},{-2.8302924429193723,-90.98430174106204},{-2.8302924429193723,-70.98430174106204},{-2.8302924429193723,-50.98430174106204},{-2.8302924429193723,-30.98430174106204},{-2.8302924429193723,-10.98430174106204},{-2.8302924429193723,9.01569825893796},{-2.8302924429193723,29.01569825893796},{-2.8302924429193723,49.01569825893796},{-2.8302924429193723,69.01569825893796},{-2.8302924429193723,89.01569825893796},{-2.8302924429193723,109.01569825893796},{17.169707557080628,109.01569825893796}},color={0,0,127}));

  //
  // End Connect Statements for 151fe7e1
  //



  //
  // Begin Connect Statements for 6fc25637
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[9],heaInd_6dbd67b3.port_a1)
    annotation (Line(points={{-20.38591785221422,726.9631182992622},{-20.38591785221422,706.9631182992622},{-20.38591785221422,686.9631182992622},{-20.38591785221422,666.9631182992622},{-20.38591785221422,646.9631182992622},{-20.38591785221422,626.9631182992622},{-20.38591785221422,606.9631182992622},{-20.38591785221422,586.9631182992622},{-20.38591785221422,566.9631182992622},{-20.38591785221422,546.9631182992622},{-20.38591785221422,526.9631182992622},{-20.38591785221422,506.9631182992622},{-20.38591785221422,486.9631182992622},{-20.38591785221422,466.9631182992622},{-20.38591785221422,446.9631182992622},{-20.38591785221422,426.9631182992622},{-20.38591785221422,406.9631182992622},{-20.38591785221422,386.9631182992622},{-20.38591785221422,366.9631182992622},{-20.38591785221422,346.9631182992622},{-20.38591785221422,326.9631182992622},{-20.38591785221422,306.9631182992622},{-20.38591785221422,286.9631182992622},{-20.38591785221422,266.9631182992622},{-20.38591785221422,246.9631182992622},{-20.38591785221422,226.9631182992622},{-20.38591785221422,206.9631182992622},{-20.38591785221422,186.9631182992622},{-20.38591785221422,166.9631182992622},{-20.38591785221422,146.9631182992622},{-20.38591785221422,126.96311829926219},{-20.38591785221422,106.96311829926219},{-0.38591785221422015,106.96311829926219},{19.61408214778578,106.96311829926219}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[9],heaInd_6dbd67b3.port_b1)
    annotation (Line(points={{-14.56278841859185,722.5442121349137},{-14.56278841859185,702.5442121349137},{-14.56278841859185,682.5442121349137},{-14.56278841859185,662.5442121349137},{-14.56278841859185,642.5442121349137},{-14.56278841859185,622.5442121349137},{-14.56278841859185,602.5442121349137},{-14.56278841859185,582.5442121349137},{-14.56278841859185,562.5442121349137},{-14.56278841859185,542.5442121349136},{-14.56278841859185,522.5442121349136},{-14.56278841859185,502.5442121349136},{-14.56278841859185,482.5442121349136},{-14.56278841859185,462.5442121349136},{-14.56278841859185,442.5442121349136},{-14.56278841859185,422.5442121349136},{-14.56278841859185,402.5442121349136},{-14.56278841859185,382.5442121349136},{-14.56278841859185,362.5442121349136},{-14.56278841859185,342.5442121349136},{-14.56278841859185,322.5442121349136},{-14.56278841859185,302.5442121349136},{-14.56278841859185,282.54421213491366},{-14.56278841859185,262.54421213491366},{-14.56278841859185,242.54421213491366},{-14.56278841859185,222.54421213491366},{-14.56278841859185,202.54421213491366},{-14.56278841859185,182.54421213491366},{-14.56278841859185,162.54421213491366},{-14.56278841859185,142.54421213491366},{-14.56278841859185,122.54421213491366},{-14.56278841859185,102.54421213491366},{5.43721158140815,102.54421213491366},{25.43721158140815,102.54421213491366}},color={0,0,127}));

  //
  // End Connect Statements for 6fc25637
  //



  //
  // Begin Connect Statements for 94bfb6a1
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_b26ccb55.ports_bChiWat[1], cooInd_08deacc6.port_a2)
    annotation (Line(points={{37.4538177397781,55.926044635195126},{17.453817739778103,55.926044635195126}},color={0,0,127}));
  connect(cooInd_08deacc6.port_b2,TimeSerLoa_b26ccb55.ports_aChiWat[1])
    annotation (Line(points={{31.693295959084153,58.46608928862088},{51.69329595908417,58.46608928862088}},color={0,0,127}));
  connect(pressure_source_94bfb6a1.ports[1], cooInd_08deacc6.port_b2)
    annotation (Line(points={{25.058759939045117,-590.7466515688993},{5.0587599390451174,-590.7466515688993},{5.0587599390451174,-570.7466515688993},{5.0587599390451174,-550.7466515688993},{5.0587599390451174,-530.7466515688993},{5.0587599390451174,-510.7466515688993},{5.0587599390451174,-490.7466515688993},{5.0587599390451174,-470.7466515688993},{5.0587599390451174,-450.7466515688993},{5.0587599390451174,-430.7466515688993},{5.0587599390451174,-410.7466515688993},{5.0587599390451174,-390.7466515688993},{5.0587599390451174,-370.7466515688993},{5.0587599390451174,-350.7466515688993},{5.0587599390451174,-330.7466515688993},{5.0587599390451174,-310.7466515688993},{5.0587599390451174,-290.7466515688993},{5.0587599390451174,-270.7466515688993},{5.0587599390451174,-250.74665156889932},{5.0587599390451174,-230.74665156889932},{5.0587599390451174,-210.74665156889932},{5.0587599390451174,-190.74665156889932},{5.0587599390451174,-170.74665156889932},{5.0587599390451174,-150.74665156889932},{5.0587599390451174,-130.74665156889932},{5.0587599390451174,-110.74665156889932},{5.0587599390451174,-90.74665156889932},{5.0587599390451174,-70.74665156889932},{5.0587599390451174,-50.746651568899324},{5.0587599390451174,-30.746651568899324},{5.0587599390451174,-10.746651568899324},{5.0587599390451174,9.253348431100676},{5.0587599390451174,29.253348431100676},{5.0587599390451174,49.253348431100676},{5.0587599390451174,69.25334843110068},{25.058759939045117,69.25334843110068}},color={0,0,127}));
  connect(TChiWatSet_94bfb6a1.y,cooInd_08deacc6.TSetBuiSup)
    annotation (Line(points={{57.68309827299552,-597.5758395457935},{37.68309827299552,-597.5758395457935},{37.68309827299552,-577.5758395457935},{37.68309827299552,-557.5758395457935},{37.68309827299552,-537.5758395457935},{37.68309827299552,-517.5758395457935},{37.68309827299552,-497.57583954579354},{37.68309827299552,-477.57583954579354},{37.68309827299552,-457.57583954579354},{37.68309827299552,-437.57583954579354},{37.68309827299552,-417.57583954579354},{37.68309827299552,-397.57583954579354},{37.68309827299552,-377.57583954579354},{37.68309827299552,-357.57583954579354},{37.68309827299552,-337.57583954579354},{37.68309827299552,-317.57583954579354},{37.68309827299552,-297.57583954579354},{37.68309827299552,-277.57583954579354},{37.68309827299552,-257.57583954579354},{37.68309827299552,-237.57583954579354},{37.68309827299552,-217.57583954579354},{37.68309827299552,-197.57583954579366},{37.68309827299552,-177.57583954579366},{37.68309827299552,-157.57583954579366},{37.68309827299552,-137.57583954579366},{37.68309827299552,-117.57583954579366},{37.68309827299552,-97.57583954579366},{37.68309827299552,-77.57583954579366},{37.68309827299552,-57.575839545793656},{37.68309827299552,-37.575839545793656},{37.68309827299552,-17.575839545793656},{37.68309827299552,2.424160454206344},{37.68309827299552,22.424160454206344},{37.68309827299552,42.424160454206344},{37.68309827299552,62.424160454206344},{57.68309827299552,62.424160454206344}},color={0,0,127}));

  //
  // End Connect Statements for 94bfb6a1
  //



  //
  // Begin Connect Statements for e0c4f24e
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[10],cooInd_08deacc6.port_a1)
    annotation (Line(points={{-18.65603072429471,762.6121852006784},{1.343969275705291,762.6121852006784},{1.343969275705291,742.6121852006784},{1.343969275705291,722.6121852006784},{1.343969275705291,702.6121852006784},{1.343969275705291,682.6121852006784},{1.343969275705291,662.6121852006784},{1.343969275705291,642.6121852006784},{1.343969275705291,622.6121852006784},{1.343969275705291,602.6121852006784},{1.343969275705291,582.6121852006784},{1.343969275705291,562.6121852006784},{1.343969275705291,542.6121852006784},{1.343969275705291,522.6121852006784},{1.343969275705291,502.6121852006784},{1.343969275705291,482.6121852006784},{1.343969275705291,462.6121852006784},{1.343969275705291,442.6121852006784},{1.343969275705291,422.6121852006784},{1.343969275705291,402.6121852006784},{1.343969275705291,382.6121852006784},{1.343969275705291,362.6121852006784},{1.343969275705291,342.6121852006784},{1.343969275705291,322.6121852006784},{1.343969275705291,302.6121852006784},{1.343969275705291,282.61218520067837},{1.343969275705291,262.61218520067837},{1.343969275705291,242.61218520067837},{1.343969275705291,222.61218520067837},{1.343969275705291,202.61218520067837},{1.343969275705291,182.61218520067837},{1.343969275705291,162.61218520067837},{1.343969275705291,142.61218520067837},{1.343969275705291,122.61218520067837},{1.343969275705291,102.61218520067837},{1.343969275705291,82.61218520067837},{1.343969275705291,62.61218520067837},{21.34396927570529,62.61218520067837}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[10],cooInd_08deacc6.port_b1)
    annotation (Line(points={{-26.67344291122243,753.5577124679629},{-6.673442911222423,753.5577124679629},{-6.673442911222423,733.5577124679629},{-6.673442911222423,713.5577124679629},{-6.673442911222423,693.5577124679629},{-6.673442911222423,673.5577124679629},{-6.673442911222423,653.5577124679629},{-6.673442911222423,633.5577124679629},{-6.673442911222423,613.5577124679629},{-6.673442911222423,593.5577124679629},{-6.673442911222423,573.5577124679629},{-6.673442911222423,553.5577124679629},{-6.673442911222423,533.5577124679629},{-6.673442911222423,513.5577124679629},{-6.673442911222423,493.5577124679629},{-6.673442911222423,473.5577124679629},{-6.673442911222423,453.5577124679629},{-6.673442911222423,433.5577124679629},{-6.673442911222423,413.5577124679629},{-6.673442911222423,393.5577124679629},{-6.673442911222423,373.5577124679629},{-6.673442911222423,353.5577124679629},{-6.673442911222423,333.5577124679629},{-6.673442911222423,313.5577124679629},{-6.673442911222423,293.5577124679629},{-6.673442911222423,273.5577124679629},{-6.673442911222423,253.55771246796292},{-6.673442911222423,233.55771246796292},{-6.673442911222423,213.55771246796292},{-6.673442911222423,193.55771246796292},{-6.673442911222423,173.55771246796292},{-6.673442911222423,153.55771246796292},{-6.673442911222423,133.55771246796292},{-6.673442911222423,113.55771246796292},{-6.673442911222423,93.55771246796292},{-6.673442911222423,73.55771246796292},{-6.673442911222423,53.557712467962915},{13.326557088777577,53.557712467962915}},color={0,0,127}));

  //
  // End Connect Statements for e0c4f24e
  //



  //
  // Begin Connect Statements for 8195cf4d
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_b26ccb55.ports_bHeaWat[1], heaInd_08d638d5.port_a2)
    annotation (Line(points={{52.02787824069324,31.133067205067164},{52.02787824069324,11.133067205067164},{32.027878240693255,11.133067205067164},{12.027878240693255,11.133067205067164}},color={0,0,127}));
  connect(heaInd_08d638d5.port_b2,TimeSerLoa_b26ccb55.ports_aHeaWat[1])
    annotation (Line(points={{12.928343113452769,37.53726348693249},{32.92834311345277,37.53726348693249},{32.92834311345277,57.53726348693249},{52.92834311345277,57.53726348693249}},color={0,0,127}));
  connect(pressure_source_8195cf4d.ports[1], heaInd_08d638d5.port_b2)
    annotation (Line(points={{-63.49647145284606,-646.1800327244366},{-43.49647145284606,-646.1800327244366},{-43.49647145284606,-626.1800327244366},{-43.49647145284606,-606.1800327244366},{-43.49647145284606,-586.1800327244366},{-43.49647145284606,-566.1800327244366},{-43.49647145284606,-546.1800327244366},{-43.49647145284606,-526.1800327244366},{-43.49647145284606,-506.1800327244366},{-43.49647145284606,-486.1800327244366},{-43.49647145284606,-466.1800327244366},{-43.49647145284606,-446.1800327244366},{-43.49647145284606,-426.1800327244366},{-43.49647145284606,-406.1800327244366},{-43.49647145284606,-386.1800327244366},{-43.49647145284606,-366.1800327244366},{-43.49647145284606,-346.1800327244366},{-43.49647145284606,-326.1800327244366},{-43.49647145284606,-306.1800327244366},{-43.49647145284606,-286.1800327244366},{-43.49647145284606,-266.1800327244366},{-43.49647145284606,-246.18003272443661},{-43.49647145284606,-226.18003272443661},{-43.49647145284606,-206.1800327244365},{-43.49647145284606,-186.1800327244365},{-43.49647145284606,-166.1800327244365},{-43.49647145284606,-146.1800327244365},{-43.49647145284606,-126.1800327244365},{-43.49647145284606,-106.1800327244365},{-43.49647145284606,-86.1800327244365},{-43.49647145284606,-66.1800327244365},{-43.49647145284606,-46.1800327244365},{-43.49647145284606,-26.1800327244365},{-43.49647145284606,-6.180032724436501},{-43.49647145284606,13.8199672755635},{-23.496471452846052,13.8199672755635},{-3.496471452846052,13.8199672755635},{16.503528547153948,13.8199672755635}},color={0,0,127}));
  connect(THeaWatSet_8195cf4d.y,heaInd_08d638d5.TSetBuiSup)
    annotation (Line(points={{-11.20389101224599,-645.1575259569056},{8.79610898775401,-645.1575259569056},{8.79610898775401,-625.1575259569056},{8.79610898775401,-605.1575259569056},{8.79610898775401,-585.1575259569056},{8.79610898775401,-565.1575259569056},{8.79610898775401,-545.1575259569056},{8.79610898775401,-525.1575259569056},{8.79610898775401,-505.1575259569056},{8.79610898775401,-485.1575259569056},{8.79610898775401,-465.1575259569056},{8.79610898775401,-445.1575259569056},{8.79610898775401,-425.1575259569056},{8.79610898775401,-405.1575259569056},{8.79610898775401,-385.1575259569056},{8.79610898775401,-365.1575259569056},{8.79610898775401,-345.1575259569056},{8.79610898775401,-325.1575259569056},{8.79610898775401,-305.1575259569056},{8.79610898775401,-285.1575259569056},{8.79610898775401,-265.1575259569056},{8.79610898775401,-245.1575259569056},{8.79610898775401,-225.1575259569056},{8.79610898775401,-205.1575259569056},{8.79610898775401,-185.1575259569056},{8.79610898775401,-165.1575259569056},{8.79610898775401,-145.1575259569056},{8.79610898775401,-125.1575259569056},{8.79610898775401,-105.1575259569056},{8.79610898775401,-85.1575259569056},{8.79610898775401,-65.1575259569056},{8.79610898775401,-45.1575259569056},{8.79610898775401,-25.1575259569056},{8.79610898775401,-5.157525956905602},{8.79610898775401,14.842474043094398},{28.79610898775401,14.842474043094398}},color={0,0,127}));

  //
  // End Connect Statements for 8195cf4d
  //



  //
  // Begin Connect Statements for 7d7fe20e
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[10],heaInd_08d638d5.port_a1)
    annotation (Line(points={{-20.200668544170597,710.7997973941214},{-20.200668544170597,690.7997973941214},{-20.200668544170597,670.7997973941214},{-20.200668544170597,650.7997973941214},{-20.200668544170597,630.7997973941214},{-20.200668544170597,610.7997973941214},{-20.200668544170597,590.7997973941214},{-20.200668544170597,570.7997973941214},{-20.200668544170597,550.7997973941214},{-20.200668544170597,530.7997973941214},{-20.200668544170597,510.79979739412136},{-20.200668544170597,490.79979739412136},{-20.200668544170597,470.79979739412136},{-20.200668544170597,450.79979739412136},{-20.200668544170597,430.79979739412136},{-20.200668544170597,410.79979739412136},{-20.200668544170597,390.79979739412136},{-20.200668544170597,370.79979739412136},{-20.200668544170597,350.79979739412136},{-20.200668544170597,330.79979739412136},{-20.200668544170597,310.79979739412136},{-20.200668544170597,290.79979739412136},{-20.200668544170597,270.79979739412136},{-20.200668544170597,250.79979739412136},{-20.200668544170597,230.79979739412136},{-20.200668544170597,210.79979739412136},{-20.200668544170597,190.79979739412136},{-20.200668544170597,170.79979739412136},{-20.200668544170597,150.79979739412136},{-20.200668544170597,130.79979739412136},{-20.200668544170597,110.79979739412136},{-20.200668544170597,90.79979739412136},{-20.200668544170597,70.79979739412136},{-20.200668544170597,50.799797394121356},{-20.200668544170597,30.799797394121356},{-20.200668544170597,10.799797394121356},{-0.20066854417059687,10.799797394121356},{19.799331455829403,10.799797394121356}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[10],heaInd_08d638d5.port_b1)
    annotation (Line(points={{-21.420200091961192,719.0347075947126},{-21.420200091961192,699.0347075947126},{-21.420200091961192,679.0347075947126},{-21.420200091961192,659.0347075947126},{-21.420200091961192,639.0347075947126},{-21.420200091961192,619.0347075947126},{-21.420200091961192,599.0347075947126},{-21.420200091961192,579.0347075947126},{-21.420200091961192,559.0347075947126},{-21.420200091961192,539.0347075947125},{-21.420200091961192,519.0347075947125},{-21.420200091961192,499.03470759471253},{-21.420200091961192,479.03470759471253},{-21.420200091961192,459.03470759471253},{-21.420200091961192,439.03470759471253},{-21.420200091961192,419.03470759471253},{-21.420200091961192,399.03470759471253},{-21.420200091961192,379.03470759471253},{-21.420200091961192,359.03470759471253},{-21.420200091961192,339.03470759471253},{-21.420200091961192,319.03470759471253},{-21.420200091961192,299.03470759471253},{-21.420200091961192,279.0347075947126},{-21.420200091961192,259.0347075947126},{-21.420200091961192,239.0347075947126},{-21.420200091961192,219.0347075947126},{-21.420200091961192,199.0347075947126},{-21.420200091961192,179.0347075947126},{-21.420200091961192,159.0347075947126},{-21.420200091961192,139.0347075947126},{-21.420200091961192,119.03470759471259},{-21.420200091961192,99.03470759471259},{-21.420200091961192,79.03470759471259},{-21.420200091961192,59.034707594712586},{-21.420200091961192,39.034707594712586},{-21.420200091961192,19.034707594712586},{-1.420200091961192,19.034707594712586},{18.579799908038808,19.034707594712586}},color={0,0,127}));

  //
  // End Connect Statements for 7d7fe20e
  //



  //
  // Begin Connect Statements for 9faf519c
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_4c16f6a9.ports_bChiWat[1], cooInd_f3301ead.port_a2)
    annotation (Line(points={{33.699785646612355,-15.192986159812676},{13.699785646612355,-15.192986159812676}},color={0,0,127}));
  connect(cooInd_f3301ead.port_b2,TimeSerLoa_4c16f6a9.ports_aChiWat[1])
    annotation (Line(points={{49.81062101802138,-11.841769370090105},{69.81062101802138,-11.841769370090105}},color={0,0,127}));
  connect(pressure_source_9faf519c.ports[1], cooInd_f3301ead.port_b2)
    annotation (Line(points={{21.867736686420415,-637.3504813335828},{1.8677366864204146,-637.3504813335828},{1.8677366864204146,-617.3504813335828},{1.8677366864204146,-597.3504813335828},{1.8677366864204146,-577.3504813335828},{1.8677366864204146,-557.3504813335828},{1.8677366864204146,-537.3504813335828},{1.8677366864204146,-517.3504813335828},{1.8677366864204146,-497.3504813335828},{1.8677366864204146,-477.3504813335828},{1.8677366864204146,-457.3504813335828},{1.8677366864204146,-437.3504813335828},{1.8677366864204146,-417.3504813335828},{1.8677366864204146,-397.3504813335828},{1.8677366864204146,-377.3504813335828},{1.8677366864204146,-357.3504813335828},{1.8677366864204146,-337.3504813335828},{1.8677366864204146,-317.3504813335828},{1.8677366864204146,-297.3504813335828},{1.8677366864204146,-277.3504813335828},{1.8677366864204146,-257.3504813335828},{1.8677366864204146,-237.35048133358282},{1.8677366864204146,-217.35048133358282},{1.8677366864204146,-197.35048133358293},{1.8677366864204146,-177.35048133358293},{1.8677366864204146,-157.35048133358293},{1.8677366864204146,-137.35048133358293},{1.8677366864204146,-117.35048133358293},{1.8677366864204146,-97.35048133358293},{1.8677366864204146,-77.35048133358293},{1.8677366864204146,-57.350481333582934},{1.8677366864204146,-37.350481333582934},{1.8677366864204146,-17.350481333582934},{21.867736686420415,-17.350481333582934}},color={0,0,127}));
  connect(TChiWatSet_9faf519c.y,cooInd_f3301ead.TSetBuiSup)
    annotation (Line(points={{55.763093052821375,-630.4656089369214},{35.763093052821375,-630.4656089369214},{35.763093052821375,-610.4656089369214},{35.763093052821375,-590.4656089369214},{35.763093052821375,-570.4656089369214},{35.763093052821375,-550.4656089369214},{35.763093052821375,-530.4656089369214},{35.763093052821375,-510.4656089369214},{35.763093052821375,-490.4656089369214},{35.763093052821375,-470.4656089369214},{35.763093052821375,-450.4656089369214},{35.763093052821375,-430.4656089369214},{35.763093052821375,-410.4656089369214},{35.763093052821375,-390.4656089369214},{35.763093052821375,-370.4656089369214},{35.763093052821375,-350.4656089369214},{35.763093052821375,-330.4656089369214},{35.763093052821375,-310.4656089369214},{35.763093052821375,-290.4656089369214},{35.763093052821375,-270.4656089369214},{35.763093052821375,-250.4656089369214},{35.763093052821375,-230.4656089369214},{35.763093052821375,-210.4656089369214},{35.763093052821375,-190.4656089369214},{35.763093052821375,-170.4656089369214},{35.763093052821375,-150.4656089369214},{35.763093052821375,-130.4656089369214},{35.763093052821375,-110.4656089369214},{35.763093052821375,-90.4656089369214},{35.763093052821375,-70.4656089369214},{35.763093052821375,-50.4656089369214},{35.763093052821375,-30.4656089369214},{35.763093052821375,-10.465608936921399},{55.763093052821375,-10.465608936921399}},color={0,0,127}));

  //
  // End Connect Statements for 9faf519c
  //



  //
  // Begin Connect Statements for 86d4747e
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[11],cooInd_f3301ead.port_a1)
    annotation (Line(points={{-27.60450250684174,753.0068500516239},{-7.60450250684174,753.0068500516239},{-7.60450250684174,733.0068500516239},{-7.60450250684174,713.0068500516239},{-7.60450250684174,693.0068500516239},{-7.60450250684174,673.0068500516239},{-7.60450250684174,653.0068500516239},{-7.60450250684174,633.0068500516239},{-7.60450250684174,613.0068500516239},{-7.60450250684174,593.0068500516239},{-7.60450250684174,573.0068500516239},{-7.60450250684174,553.0068500516239},{-7.60450250684174,533.0068500516239},{-7.60450250684174,513.0068500516239},{-7.60450250684174,493.0068500516239},{-7.60450250684174,473.0068500516239},{-7.60450250684174,453.0068500516239},{-7.60450250684174,433.0068500516239},{-7.60450250684174,413.0068500516239},{-7.60450250684174,393.0068500516239},{-7.60450250684174,373.0068500516239},{-7.60450250684174,353.0068500516239},{-7.60450250684174,333.0068500516239},{-7.60450250684174,313.0068500516239},{-7.60450250684174,293.0068500516239},{-7.60450250684174,273.0068500516239},{-7.60450250684174,253.00685005162393},{-7.60450250684174,233.00685005162393},{-7.60450250684174,213.00685005162393},{-7.60450250684174,193.00685005162393},{-7.60450250684174,173.00685005162393},{-7.60450250684174,153.00685005162393},{-7.60450250684174,133.00685005162393},{-7.60450250684174,113.00685005162393},{-7.60450250684174,93.00685005162393},{-7.60450250684174,73.00685005162393},{-7.60450250684174,53.00685005162393},{-7.60450250684174,33.00685005162393},{-7.60450250684174,13.006850051623928},{-7.60450250684174,-6.993149948376072},{-7.60450250684174,-26.99314994837607},{12.39549749315826,-26.99314994837607}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[11],cooInd_f3301ead.port_b1)
    annotation (Line(points={{-27.322101924118734,769.4088838337029},{-7.322101924118726,769.4088838337029},{-7.322101924118726,749.4088838337029},{-7.322101924118726,729.4088838337029},{-7.322101924118726,709.4088838337029},{-7.322101924118726,689.4088838337029},{-7.322101924118726,669.4088838337029},{-7.322101924118726,649.4088838337029},{-7.322101924118726,629.4088838337029},{-7.322101924118726,609.4088838337029},{-7.322101924118726,589.4088838337029},{-7.322101924118726,569.4088838337029},{-7.322101924118726,549.4088838337029},{-7.322101924118726,529.4088838337029},{-7.322101924118726,509.408883833703},{-7.322101924118726,489.408883833703},{-7.322101924118726,469.408883833703},{-7.322101924118726,449.408883833703},{-7.322101924118726,429.408883833703},{-7.322101924118726,409.408883833703},{-7.322101924118726,389.408883833703},{-7.322101924118726,369.408883833703},{-7.322101924118726,349.408883833703},{-7.322101924118726,329.408883833703},{-7.322101924118726,309.408883833703},{-7.322101924118726,289.40888383370293},{-7.322101924118726,269.40888383370293},{-7.322101924118726,249.40888383370293},{-7.322101924118726,229.40888383370293},{-7.322101924118726,209.40888383370293},{-7.322101924118726,189.40888383370293},{-7.322101924118726,169.40888383370293},{-7.322101924118726,149.40888383370293},{-7.322101924118726,129.40888383370293},{-7.322101924118726,109.40888383370293},{-7.322101924118726,89.40888383370293},{-7.322101924118726,69.40888383370293},{-7.322101924118726,49.40888383370293},{-7.322101924118726,29.40888383370293},{-7.322101924118726,9.40888383370293},{-7.322101924118726,-10.59111616629707},{12.677898075881274,-10.59111616629707}},color={0,0,127}));

  //
  // End Connect Statements for 86d4747e
  //



  //
  // Begin Connect Statements for 0d7b23e4
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_4c16f6a9.ports_bHeaWat[1], heaInd_75ba26e5.port_a2)
    annotation (Line(points={{66.08992131811135,-48.07354765549201},{66.08992131811135,-68.073547655492},{46.08992131811135,-68.073547655492},{26.08992131811135,-68.073547655492}},color={0,0,127}));
  connect(heaInd_75ba26e5.port_b2,TimeSerLoa_4c16f6a9.ports_aHeaWat[1])
    annotation (Line(points={{27.453463384643044,-42.77448104302994},{47.453463384643044,-42.77448104302994},{47.453463384643044,-22.774481043029937},{67.45346338464304,-22.774481043029937}},color={0,0,127}));
  connect(pressure_source_0d7b23e4.ports[1], heaInd_75ba26e5.port_b2)
    annotation (Line(points={{-55.65666226509747,-687.3050836320997},{-35.65666226509747,-687.3050836320997},{-35.65666226509747,-667.3050836320997},{-35.65666226509747,-647.3050836320997},{-35.65666226509747,-627.3050836320997},{-35.65666226509747,-607.3050836320997},{-35.65666226509747,-587.3050836320997},{-35.65666226509747,-567.3050836320997},{-35.65666226509747,-547.3050836320997},{-35.65666226509747,-527.3050836320997},{-35.65666226509747,-507.3050836320997},{-35.65666226509747,-487.3050836320997},{-35.65666226509747,-467.3050836320997},{-35.65666226509747,-447.3050836320997},{-35.65666226509747,-427.3050836320997},{-35.65666226509747,-407.3050836320997},{-35.65666226509747,-387.3050836320997},{-35.65666226509747,-367.3050836320997},{-35.65666226509747,-347.3050836320997},{-35.65666226509747,-327.3050836320997},{-35.65666226509747,-307.3050836320997},{-35.65666226509747,-287.3050836320997},{-35.65666226509747,-267.3050836320997},{-35.65666226509747,-247.3050836320997},{-35.65666226509747,-227.3050836320997},{-35.65666226509747,-207.3050836320997},{-35.65666226509747,-187.3050836320997},{-35.65666226509747,-167.3050836320997},{-35.65666226509747,-147.3050836320997},{-35.65666226509747,-127.3050836320997},{-35.65666226509747,-107.3050836320997},{-35.65666226509747,-87.3050836320997},{-35.65666226509747,-67.3050836320997},{-15.656662265097467,-67.3050836320997},{4.3433377349025335,-67.3050836320997},{24.343337734902533,-67.3050836320997}},color={0,0,127}));
  connect(THeaWatSet_0d7b23e4.y,heaInd_75ba26e5.TSetBuiSup)
    annotation (Line(points={{-16.354683244230046,-675.8398376628411},{3.6453167557699544,-675.8398376628411},{3.6453167557699544,-655.8398376628411},{3.6453167557699544,-635.8398376628411},{3.6453167557699544,-615.8398376628411},{3.6453167557699544,-595.8398376628411},{3.6453167557699544,-575.8398376628411},{3.6453167557699544,-555.8398376628411},{3.6453167557699544,-535.8398376628411},{3.6453167557699544,-515.8398376628411},{3.6453167557699544,-495.8398376628411},{3.6453167557699544,-475.8398376628411},{3.6453167557699544,-455.8398376628411},{3.6453167557699544,-435.8398376628411},{3.6453167557699544,-415.8398376628411},{3.6453167557699544,-395.8398376628411},{3.6453167557699544,-375.8398376628411},{3.6453167557699544,-355.8398376628411},{3.6453167557699544,-335.8398376628411},{3.6453167557699544,-315.8398376628411},{3.6453167557699544,-295.8398376628411},{3.6453167557699544,-275.8398376628411},{3.6453167557699544,-255.8398376628411},{3.6453167557699544,-235.8398376628411},{3.6453167557699544,-215.8398376628411},{3.6453167557699544,-195.8398376628412},{3.6453167557699544,-175.8398376628412},{3.6453167557699544,-155.8398376628412},{3.6453167557699544,-135.8398376628412},{3.6453167557699544,-115.8398376628412},{3.6453167557699544,-95.8398376628412},{3.6453167557699544,-75.8398376628412},{3.6453167557699544,-55.839837662841205},{23.645316755769954,-55.839837662841205}},color={0,0,127}));

  //
  // End Connect Statements for 0d7b23e4
  //



  //
  // Begin Connect Statements for 4ab595fa
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[11],heaInd_75ba26e5.port_a1)
    annotation (Line(points={{-12.990241858442076,727.1069811036463},{-12.990241858442076,707.1069811036463},{-12.990241858442076,687.1069811036463},{-12.990241858442076,667.1069811036463},{-12.990241858442076,647.1069811036463},{-12.990241858442076,627.1069811036463},{-12.990241858442076,607.1069811036463},{-12.990241858442076,587.1069811036463},{-12.990241858442076,567.1069811036463},{-12.990241858442076,547.1069811036463},{-12.990241858442076,527.1069811036463},{-12.990241858442076,507.10698110364626},{-12.990241858442076,487.10698110364626},{-12.990241858442076,467.10698110364626},{-12.990241858442076,447.10698110364626},{-12.990241858442076,427.10698110364626},{-12.990241858442076,407.10698110364626},{-12.990241858442076,387.10698110364626},{-12.990241858442076,367.10698110364626},{-12.990241858442076,347.10698110364626},{-12.990241858442076,327.10698110364626},{-12.990241858442076,307.10698110364626},{-12.990241858442076,287.10698110364626},{-12.990241858442076,267.10698110364626},{-12.990241858442076,247.10698110364626},{-12.990241858442076,227.10698110364626},{-12.990241858442076,207.10698110364626},{-12.990241858442076,187.10698110364626},{-12.990241858442076,167.10698110364626},{-12.990241858442076,147.10698110364626},{-12.990241858442076,127.10698110364626},{-12.990241858442076,107.10698110364626},{-12.990241858442076,87.10698110364626},{-12.990241858442076,67.10698110364626},{-12.990241858442076,47.10698110364626},{-12.990241858442076,27.106981103646262},{-12.990241858442076,7.1069811036462625},{-12.990241858442076,-12.893018896353738},{-12.990241858442076,-32.89301889635374},{-12.990241858442076,-52.89301889635374},{7.009758141557924,-52.89301889635374},{27.009758141557924,-52.89301889635374}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[11],heaInd_75ba26e5.port_b1)
    annotation (Line(points={{-23.53430423570454,721.5858091994315},{-23.53430423570454,701.5858091994315},{-23.53430423570454,681.5858091994315},{-23.53430423570454,661.5858091994315},{-23.53430423570454,641.5858091994315},{-23.53430423570454,621.5858091994315},{-23.53430423570454,601.5858091994315},{-23.53430423570454,581.5858091994315},{-23.53430423570454,561.5858091994315},{-23.53430423570454,541.5858091994315},{-23.53430423570454,521.5858091994315},{-23.53430423570454,501.58580919943154},{-23.53430423570454,481.58580919943154},{-23.53430423570454,461.58580919943154},{-23.53430423570454,441.58580919943154},{-23.53430423570454,421.58580919943154},{-23.53430423570454,401.58580919943154},{-23.53430423570454,381.58580919943154},{-23.53430423570454,361.58580919943154},{-23.53430423570454,341.58580919943154},{-23.53430423570454,321.58580919943154},{-23.53430423570454,301.58580919943154},{-23.53430423570454,281.58580919943154},{-23.53430423570454,261.58580919943154},{-23.53430423570454,241.58580919943154},{-23.53430423570454,221.58580919943154},{-23.53430423570454,201.58580919943154},{-23.53430423570454,181.58580919943154},{-23.53430423570454,161.58580919943154},{-23.53430423570454,141.58580919943154},{-23.53430423570454,121.58580919943154},{-23.53430423570454,101.58580919943154},{-23.53430423570454,81.58580919943154},{-23.53430423570454,61.58580919943154},{-23.53430423570454,41.58580919943154},{-23.53430423570454,21.585809199431537},{-23.53430423570454,1.5858091994315373},{-23.53430423570454,-18.414190800568463},{-23.53430423570454,-38.41419080056846},{-23.53430423570454,-58.41419080056846},{-3.534304235704539,-58.41419080056846},{16.46569576429546,-58.41419080056846}},color={0,0,127}));

  //
  // End Connect Statements for 4ab595fa
  //



  //
  // Begin Connect Statements for 64fb8580
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_46c51900.ports_bChiWat[1], cooInd_0c0ee305.port_a2)
    annotation (Line(points={{39.69190587094582,-92.38103500650493},{19.691905870945817,-92.38103500650493}},color={0,0,127}));
  connect(cooInd_0c0ee305.port_b2,TimeSerLoa_46c51900.ports_aChiWat[1])
    annotation (Line(points={{47.03931950971585,-96.12130420030655},{67.03931950971585,-96.12130420030655}},color={0,0,127}));
  connect(pressure_source_64fb8580.ports[1], cooInd_0c0ee305.port_b2)
    annotation (Line(points={{29.87897176369782,-674.1362140952856},{9.87897176369782,-674.1362140952856},{9.87897176369782,-654.1362140952856},{9.87897176369782,-634.1362140952856},{9.87897176369782,-614.1362140952856},{9.87897176369782,-594.1362140952856},{9.87897176369782,-574.1362140952856},{9.87897176369782,-554.1362140952856},{9.87897176369782,-534.1362140952856},{9.87897176369782,-514.1362140952856},{9.87897176369782,-494.1362140952856},{9.87897176369782,-474.1362140952856},{9.87897176369782,-454.1362140952856},{9.87897176369782,-434.1362140952856},{9.87897176369782,-414.1362140952856},{9.87897176369782,-394.1362140952856},{9.87897176369782,-374.1362140952856},{9.87897176369782,-354.1362140952856},{9.87897176369782,-334.1362140952856},{9.87897176369782,-314.1362140952856},{9.87897176369782,-294.1362140952856},{9.87897176369782,-274.1362140952856},{9.87897176369782,-254.1362140952856},{9.87897176369782,-234.1362140952856},{9.87897176369782,-214.1362140952856},{9.87897176369782,-194.13621409528548},{9.87897176369782,-174.13621409528548},{9.87897176369782,-154.13621409528548},{9.87897176369782,-134.13621409528548},{9.87897176369782,-114.13621409528548},{9.87897176369782,-94.13621409528548},{29.87897176369782,-94.13621409528548}},color={0,0,127}));
  connect(TChiWatSet_64fb8580.y,cooInd_0c0ee305.TSetBuiSup)
    annotation (Line(points={{59.65550867091275,-684.2519459058253},{39.65550867091275,-684.2519459058253},{39.65550867091275,-664.2519459058253},{39.65550867091275,-644.2519459058253},{39.65550867091275,-624.2519459058253},{39.65550867091275,-604.2519459058253},{39.65550867091275,-584.2519459058253},{39.65550867091275,-564.2519459058253},{39.65550867091275,-544.2519459058253},{39.65550867091275,-524.2519459058253},{39.65550867091275,-504.2519459058253},{39.65550867091275,-484.2519459058253},{39.65550867091275,-464.2519459058253},{39.65550867091275,-444.2519459058253},{39.65550867091275,-424.2519459058253},{39.65550867091275,-404.2519459058253},{39.65550867091275,-384.2519459058253},{39.65550867091275,-364.2519459058253},{39.65550867091275,-344.2519459058253},{39.65550867091275,-324.2519459058253},{39.65550867091275,-304.2519459058253},{39.65550867091275,-284.2519459058253},{39.65550867091275,-264.2519459058253},{39.65550867091275,-244.25194590582532},{39.65550867091275,-224.25194590582532},{39.65550867091275,-204.25194590582544},{39.65550867091275,-184.25194590582544},{39.65550867091275,-164.25194590582544},{39.65550867091275,-144.25194590582544},{39.65550867091275,-124.25194590582544},{39.65550867091275,-104.25194590582544},{59.65550867091275,-104.25194590582544}},color={0,0,127}));

  //
  // End Connect Statements for 64fb8580
  //



  //
  // Begin Connect Statements for b1d91a23
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[12],cooInd_0c0ee305.port_a1)
    annotation (Line(points={{-25.85810835005647,755.1847822373534},{-5.858108350056469,755.1847822373534},{-5.858108350056469,735.1847822373534},{-5.858108350056469,715.1847822373534},{-5.858108350056469,695.1847822373534},{-5.858108350056469,675.1847822373534},{-5.858108350056469,655.1847822373534},{-5.858108350056469,635.1847822373534},{-5.858108350056469,615.1847822373534},{-5.858108350056469,595.1847822373534},{-5.858108350056469,575.1847822373534},{-5.858108350056469,555.1847822373534},{-5.858108350056469,535.1847822373534},{-5.858108350056469,515.1847822373534},{-5.858108350056469,495.1847822373533},{-5.858108350056469,475.1847822373533},{-5.858108350056469,455.1847822373533},{-5.858108350056469,435.1847822373533},{-5.858108350056469,415.1847822373533},{-5.858108350056469,395.1847822373533},{-5.858108350056469,375.1847822373533},{-5.858108350056469,355.1847822373533},{-5.858108350056469,335.1847822373533},{-5.858108350056469,315.1847822373533},{-5.858108350056469,295.1847822373534},{-5.858108350056469,275.1847822373534},{-5.858108350056469,255.18478223735337},{-5.858108350056469,235.18478223735337},{-5.858108350056469,215.18478223735337},{-5.858108350056469,195.18478223735337},{-5.858108350056469,175.18478223735337},{-5.858108350056469,155.18478223735337},{-5.858108350056469,135.18478223735337},{-5.858108350056469,115.18478223735337},{-5.858108350056469,95.18478223735337},{-5.858108350056469,75.18478223735337},{-5.858108350056469,55.184782237353375},{-5.858108350056469,35.184782237353375},{-5.858108350056469,15.184782237353375},{-5.858108350056469,-4.8152177626466255},{-5.858108350056469,-24.815217762646625},{-5.858108350056469,-44.815217762646625},{-5.858108350056469,-64.81521776264663},{-5.858108350056469,-84.81521776264663},{-5.858108350056469,-104.81521776264663},{14.141891649943531,-104.81521776264663}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[12],cooInd_0c0ee305.port_b1)
    annotation (Line(points={{-21.054675703036636,759.2540324952979},{-1.0546757030366365,759.2540324952979},{-1.0546757030366365,739.2540324952979},{-1.0546757030366365,719.2540324952979},{-1.0546757030366365,699.2540324952979},{-1.0546757030366365,679.2540324952979},{-1.0546757030366365,659.2540324952979},{-1.0546757030366365,639.2540324952979},{-1.0546757030366365,619.2540324952979},{-1.0546757030366365,599.2540324952979},{-1.0546757030366365,579.2540324952979},{-1.0546757030366365,559.2540324952979},{-1.0546757030366365,539.2540324952979},{-1.0546757030366365,519.2540324952979},{-1.0546757030366365,499.25403249529796},{-1.0546757030366365,479.25403249529796},{-1.0546757030366365,459.25403249529796},{-1.0546757030366365,439.25403249529796},{-1.0546757030366365,419.25403249529796},{-1.0546757030366365,399.25403249529796},{-1.0546757030366365,379.25403249529796},{-1.0546757030366365,359.25403249529796},{-1.0546757030366365,339.25403249529796},{-1.0546757030366365,319.25403249529796},{-1.0546757030366365,299.25403249529796},{-1.0546757030366365,279.2540324952979},{-1.0546757030366365,259.2540324952979},{-1.0546757030366365,239.2540324952979},{-1.0546757030366365,219.2540324952979},{-1.0546757030366365,199.2540324952979},{-1.0546757030366365,179.2540324952979},{-1.0546757030366365,159.2540324952979},{-1.0546757030366365,139.2540324952979},{-1.0546757030366365,119.2540324952979},{-1.0546757030366365,99.2540324952979},{-1.0546757030366365,79.2540324952979},{-1.0546757030366365,59.254032495297906},{-1.0546757030366365,39.254032495297906},{-1.0546757030366365,19.254032495297906},{-1.0546757030366365,-0.7459675047020937},{-1.0546757030366365,-20.745967504702094},{-1.0546757030366365,-40.745967504702094},{-1.0546757030366365,-60.745967504702094},{-1.0546757030366365,-80.7459675047021},{-1.0546757030366365,-100.7459675047021},{18.945324296963364,-100.7459675047021}},color={0,0,127}));

  //
  // End Connect Statements for b1d91a23
  //



  //
  // Begin Connect Statements for 5685d516
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_46c51900.ports_bHeaWat[1], heaInd_518226dd.port_a2)
    annotation (Line(points={{68.8077398033079,-128.36683163299892},{68.8077398033079,-148.36683163299892},{48.807739803307896,-148.36683163299892},{28.807739803307896,-148.36683163299892}},color={0,0,127}));
  connect(heaInd_518226dd.port_b2,TimeSerLoa_46c51900.ports_aHeaWat[1])
    annotation (Line(points={{23.273673005011375,-121.82475085793044},{43.273673005011375,-121.82475085793044},{43.273673005011375,-101.82475085793044},{63.273673005011375,-101.82475085793044}},color={0,0,127}));
  connect(pressure_source_5685d516.ports[1], heaInd_518226dd.port_b2)
    annotation (Line(points={{-68.39383773643803,-716.1184579895626},{-48.39383773643803,-716.1184579895626},{-48.39383773643803,-696.1184579895626},{-48.39383773643803,-676.1184579895626},{-48.39383773643803,-656.1184579895626},{-48.39383773643803,-636.1184579895626},{-48.39383773643803,-616.1184579895626},{-48.39383773643803,-596.1184579895626},{-48.39383773643803,-576.1184579895626},{-48.39383773643803,-556.1184579895626},{-48.39383773643803,-536.1184579895626},{-48.39383773643803,-516.1184579895626},{-48.39383773643803,-496.11845798956256},{-48.39383773643803,-476.11845798956256},{-48.39383773643803,-456.11845798956256},{-48.39383773643803,-436.11845798956256},{-48.39383773643803,-416.11845798956256},{-48.39383773643803,-396.11845798956256},{-48.39383773643803,-376.11845798956256},{-48.39383773643803,-356.11845798956256},{-48.39383773643803,-336.11845798956256},{-48.39383773643803,-316.11845798956256},{-48.39383773643803,-296.11845798956256},{-48.39383773643803,-276.11845798956256},{-48.39383773643803,-256.11845798956256},{-48.39383773643803,-236.11845798956256},{-48.39383773643803,-216.11845798956256},{-48.39383773643803,-196.11845798956256},{-48.39383773643803,-176.11845798956256},{-48.39383773643803,-156.11845798956256},{-48.39383773643803,-136.11845798956256},{-28.39383773643803,-136.11845798956256},{-8.39383773643803,-136.11845798956256},{11.60616226356197,-136.11845798956256}},color={0,0,127}));
  connect(THeaWatSet_5685d516.y,heaInd_518226dd.TSetBuiSup)
    annotation (Line(points={{-28.36510278817623,-710.7763620214187},{-8.36510278817623,-710.7763620214187},{-8.36510278817623,-690.7763620214187},{-8.36510278817623,-670.7763620214187},{-8.36510278817623,-650.7763620214187},{-8.36510278817623,-630.7763620214187},{-8.36510278817623,-610.7763620214187},{-8.36510278817623,-590.7763620214187},{-8.36510278817623,-570.7763620214187},{-8.36510278817623,-550.7763620214187},{-8.36510278817623,-530.7763620214187},{-8.36510278817623,-510.77636202141866},{-8.36510278817623,-490.77636202141866},{-8.36510278817623,-470.77636202141866},{-8.36510278817623,-450.77636202141866},{-8.36510278817623,-430.77636202141866},{-8.36510278817623,-410.77636202141866},{-8.36510278817623,-390.77636202141866},{-8.36510278817623,-370.77636202141866},{-8.36510278817623,-350.77636202141866},{-8.36510278817623,-330.77636202141866},{-8.36510278817623,-310.77636202141866},{-8.36510278817623,-290.77636202141866},{-8.36510278817623,-270.77636202141866},{-8.36510278817623,-250.77636202141866},{-8.36510278817623,-230.77636202141866},{-8.36510278817623,-210.77636202141866},{-8.36510278817623,-190.77636202141866},{-8.36510278817623,-170.77636202141866},{-8.36510278817623,-150.77636202141866},{-8.36510278817623,-130.77636202141866},{11.63489721182377,-130.77636202141866}},color={0,0,127}));

  //
  // End Connect Statements for 5685d516
  //



  //
  // Begin Connect Statements for f76aeb36
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[12],heaInd_518226dd.port_a1)
    annotation (Line(points={{-24.935427937965144,716.3096070843061},{-24.935427937965144,696.3096070843061},{-24.935427937965144,676.3096070843061},{-24.935427937965144,656.3096070843061},{-24.935427937965144,636.3096070843061},{-24.935427937965144,616.3096070843061},{-24.935427937965144,596.3096070843061},{-24.935427937965144,576.3096070843061},{-24.935427937965144,556.3096070843061},{-24.935427937965144,536.309607084306},{-24.935427937965144,516.309607084306},{-24.935427937965144,496.30960708430604},{-24.935427937965144,476.30960708430604},{-24.935427937965144,456.30960708430604},{-24.935427937965144,436.30960708430604},{-24.935427937965144,416.30960708430604},{-24.935427937965144,396.30960708430604},{-24.935427937965144,376.30960708430604},{-24.935427937965144,356.30960708430604},{-24.935427937965144,336.30960708430604},{-24.935427937965144,316.30960708430604},{-24.935427937965144,296.3096070843061},{-24.935427937965144,276.3096070843061},{-24.935427937965144,256.3096070843061},{-24.935427937965144,236.3096070843061},{-24.935427937965144,216.3096070843061},{-24.935427937965144,196.3096070843061},{-24.935427937965144,176.3096070843061},{-24.935427937965144,156.3096070843061},{-24.935427937965144,136.3096070843061},{-24.935427937965144,116.3096070843061},{-24.935427937965144,96.3096070843061},{-24.935427937965144,76.3096070843061},{-24.935427937965144,56.309607084306094},{-24.935427937965144,36.309607084306094},{-24.935427937965144,16.309607084306094},{-24.935427937965144,-3.6903929156939057},{-24.935427937965144,-23.690392915693906},{-24.935427937965144,-43.690392915693906},{-24.935427937965144,-63.690392915693906},{-24.935427937965144,-83.6903929156939},{-24.935427937965144,-103.6903929156939},{-24.935427937965144,-123.6903929156939},{-24.935427937965144,-143.6903929156939},{-4.9354279379651445,-143.6903929156939},{15.064572062034856,-143.6903929156939}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[12],heaInd_518226dd.port_b1)
    annotation (Line(points={{-10.591068459203697,719.7238797954444},{-10.591068459203697,699.7238797954444},{-10.591068459203697,679.7238797954444},{-10.591068459203697,659.7238797954444},{-10.591068459203697,639.7238797954444},{-10.591068459203697,619.7238797954444},{-10.591068459203697,599.7238797954444},{-10.591068459203697,579.7238797954444},{-10.591068459203697,559.7238797954444},{-10.591068459203697,539.7238797954444},{-10.591068459203697,519.7238797954444},{-10.591068459203697,499.7238797954445},{-10.591068459203697,479.7238797954445},{-10.591068459203697,459.7238797954445},{-10.591068459203697,439.7238797954445},{-10.591068459203697,419.7238797954445},{-10.591068459203697,399.7238797954445},{-10.591068459203697,379.7238797954445},{-10.591068459203697,359.7238797954445},{-10.591068459203697,339.7238797954445},{-10.591068459203697,319.7238797954445},{-10.591068459203697,299.7238797954445},{-10.591068459203697,279.7238797954444},{-10.591068459203697,259.7238797954444},{-10.591068459203697,239.72387979544442},{-10.591068459203697,219.72387979544442},{-10.591068459203697,199.72387979544442},{-10.591068459203697,179.72387979544442},{-10.591068459203697,159.72387979544442},{-10.591068459203697,139.72387979544442},{-10.591068459203697,119.72387979544442},{-10.591068459203697,99.72387979544442},{-10.591068459203697,79.72387979544442},{-10.591068459203697,59.72387979544442},{-10.591068459203697,39.72387979544442},{-10.591068459203697,19.723879795444418},{-10.591068459203697,-0.27612020455558195},{-10.591068459203697,-20.276120204555582},{-10.591068459203697,-40.27612020455558},{-10.591068459203697,-60.27612020455558},{-10.591068459203697,-80.27612020455558},{-10.591068459203697,-100.27612020455558},{-10.591068459203697,-120.27612020455558},{-10.591068459203697,-140.27612020455558},{9.408931540796303,-140.27612020455558},{29.408931540796303,-140.27612020455558}},color={0,0,127}));

  //
  // End Connect Statements for f76aeb36
  //



  //
  // Begin Connect Statements for dd3d24c6
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_2561f077.ports_bChiWat[1], cooInd_b9465691.port_a2)
    annotation (Line(points={{52.748346404394624,-209.44649889497828},{52.748346404394624,-229.44649889497828},{32.74834640439464,-229.44649889497828},{12.748346404394638,-229.44649889497828}},color={0,0,127}));
  connect(cooInd_b9465691.port_b2,TimeSerLoa_2561f077.ports_aChiWat[1])
    annotation (Line(points={{19.34910854530783,-202.55259214353418},{39.349108545307814,-202.55259214353418},{39.349108545307814,-182.55259214353418},{59.349108545307814,-182.55259214353418}},color={0,0,127}));
  connect(pressure_source_dd3d24c6.ports[1], cooInd_b9465691.port_b2)
    annotation (Line(points={{24.47265084610575,-727.2230738447636},{4.472650846105751,-727.2230738447636},{4.472650846105751,-707.2230738447636},{4.472650846105751,-687.2230738447636},{4.472650846105751,-667.2230738447636},{4.472650846105751,-647.2230738447636},{4.472650846105751,-627.2230738447636},{4.472650846105751,-607.2230738447636},{4.472650846105751,-587.2230738447636},{4.472650846105751,-567.2230738447636},{4.472650846105751,-547.2230738447636},{4.472650846105751,-527.2230738447636},{4.472650846105751,-507.2230738447636},{4.472650846105751,-487.2230738447636},{4.472650846105751,-467.2230738447636},{4.472650846105751,-447.2230738447636},{4.472650846105751,-427.2230738447636},{4.472650846105751,-407.2230738447636},{4.472650846105751,-387.2230738447636},{4.472650846105751,-367.2230738447636},{4.472650846105751,-347.2230738447636},{4.472650846105751,-327.2230738447636},{4.472650846105751,-307.2230738447636},{4.472650846105751,-287.2230738447636},{4.472650846105751,-267.2230738447636},{4.472650846105751,-247.22307384476358},{4.472650846105751,-227.22307384476358},{24.47265084610575,-227.22307384476358}},color={0,0,127}));
  connect(TChiWatSet_dd3d24c6.y,cooInd_b9465691.TSetBuiSup)
    annotation (Line(points={{55.04143340639061,-723.9020067314518},{35.04143340639061,-723.9020067314518},{35.04143340639061,-703.9020067314518},{35.04143340639061,-683.9020067314518},{35.04143340639061,-663.9020067314518},{35.04143340639061,-643.9020067314518},{35.04143340639061,-623.9020067314518},{35.04143340639061,-603.9020067314518},{35.04143340639061,-583.9020067314518},{35.04143340639061,-563.9020067314518},{35.04143340639061,-543.9020067314518},{35.04143340639061,-523.9020067314518},{35.04143340639061,-503.9020067314518},{35.04143340639061,-483.9020067314518},{35.04143340639061,-463.9020067314518},{35.04143340639061,-443.9020067314518},{35.04143340639061,-423.9020067314518},{35.04143340639061,-403.9020067314518},{35.04143340639061,-383.9020067314518},{35.04143340639061,-363.9020067314518},{35.04143340639061,-343.9020067314518},{35.04143340639061,-323.9020067314518},{35.04143340639061,-303.9020067314518},{35.04143340639061,-283.9020067314518},{35.04143340639061,-263.9020067314518},{35.04143340639061,-243.90200673145182},{35.04143340639061,-223.90200673145182},{35.04143340639061,-203.90200673145182},{35.04143340639061,-183.90200673145182},{55.04143340639061,-183.90200673145182}},color={0,0,127}));

  //
  // End Connect Statements for dd3d24c6
  //



  //
  // Begin Connect Statements for 4a4eaa29
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_c4e29af7.ports_bCon[13],cooInd_b9465691.port_a1)
    annotation (Line(points={{-15.146697840849612,763.5099308715908},{4.853302159150388,763.5099308715908},{4.853302159150388,743.5099308715908},{4.853302159150388,723.5099308715908},{4.853302159150388,703.5099308715908},{4.853302159150388,683.5099308715908},{4.853302159150388,663.5099308715908},{4.853302159150388,643.5099308715908},{4.853302159150388,623.5099308715908},{4.853302159150388,603.5099308715908},{4.853302159150388,583.5099308715908},{4.853302159150388,563.5099308715908},{4.853302159150388,543.5099308715908},{4.853302159150388,523.5099308715908},{4.853302159150388,503.5099308715907},{4.853302159150388,483.5099308715907},{4.853302159150388,463.5099308715907},{4.853302159150388,443.5099308715907},{4.853302159150388,423.5099308715907},{4.853302159150388,403.5099308715907},{4.853302159150388,383.5099308715907},{4.853302159150388,363.5099308715907},{4.853302159150388,343.5099308715907},{4.853302159150388,323.5099308715907},{4.853302159150388,303.5099308715907},{4.853302159150388,283.50993087159077},{4.853302159150388,263.50993087159077},{4.853302159150388,243.50993087159077},{4.853302159150388,223.50993087159077},{4.853302159150388,203.50993087159077},{4.853302159150388,183.50993087159077},{4.853302159150388,163.50993087159077},{4.853302159150388,143.50993087159077},{4.853302159150388,123.50993087159077},{4.853302159150388,103.50993087159077},{4.853302159150388,83.50993087159077},{4.853302159150388,63.50993087159077},{4.853302159150388,43.50993087159077},{4.853302159150388,23.509930871590768},{4.853302159150388,3.509930871590768},{4.853302159150388,-16.490069128409232},{4.853302159150388,-36.49006912840923},{4.853302159150388,-56.49006912840923},{4.853302159150388,-76.49006912840923},{4.853302159150388,-96.49006912840923},{4.853302159150388,-116.49006912840923},{4.853302159150388,-136.49006912840923},{4.853302159150388,-156.49006912840923},{4.853302159150388,-176.49006912840923},{4.853302159150388,-196.49006912840923},{4.853302159150388,-216.49006912840923},{24.853302159150388,-216.49006912840923}},color={0,0,127}));
  connect(disNet_c4e29af7.ports_aCon[13],cooInd_b9465691.port_b1)
    annotation (Line(points={{-12.524869934311369,752.9717945979179},{7.4751300656886315,752.9717945979179},{7.4751300656886315,732.9717945979179},{7.4751300656886315,712.9717945979179},{7.4751300656886315,692.9717945979179},{7.4751300656886315,672.9717945979179},{7.4751300656886315,652.9717945979179},{7.4751300656886315,632.9717945979179},{7.4751300656886315,612.9717945979179},{7.4751300656886315,592.9717945979179},{7.4751300656886315,572.9717945979179},{7.4751300656886315,552.971794597918},{7.4751300656886315,532.971794597918},{7.4751300656886315,512.971794597918},{7.4751300656886315,492.97179459791795},{7.4751300656886315,472.97179459791795},{7.4751300656886315,452.97179459791795},{7.4751300656886315,432.97179459791795},{7.4751300656886315,412.97179459791795},{7.4751300656886315,392.97179459791795},{7.4751300656886315,372.97179459791795},{7.4751300656886315,352.97179459791795},{7.4751300656886315,332.97179459791795},{7.4751300656886315,312.97179459791795},{7.4751300656886315,292.9717945979179},{7.4751300656886315,272.9717945979179},{7.4751300656886315,252.9717945979179},{7.4751300656886315,232.9717945979179},{7.4751300656886315,212.9717945979179},{7.4751300656886315,192.9717945979179},{7.4751300656886315,172.9717945979179},{7.4751300656886315,152.9717945979179},{7.4751300656886315,132.9717945979179},{7.4751300656886315,112.97179459791789},{7.4751300656886315,92.97179459791789},{7.4751300656886315,72.97179459791789},{7.4751300656886315,52.97179459791789},{7.4751300656886315,32.97179459791789},{7.4751300656886315,12.971794597917892},{7.4751300656886315,-7.028205402082108},{7.4751300656886315,-27.028205402082108},{7.4751300656886315,-47.02820540208211},{7.4751300656886315,-67.02820540208211},{7.4751300656886315,-87.02820540208211},{7.4751300656886315,-107.02820540208211},{7.4751300656886315,-127.02820540208211},{7.4751300656886315,-147.0282054020821},{7.4751300656886315,-167.0282054020821},{7.4751300656886315,-187.0282054020821},{7.4751300656886315,-207.0282054020821},{7.4751300656886315,-227.028205402082},{27.47513006568863,-227.028205402082}},color={0,0,127}));

  //
  // End Connect Statements for 4a4eaa29
  //



  //
  // Begin Connect Statements for 13386826
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_2561f077.ports_bHeaWat[1], heaInd_d8a757c3.port_a2)
    annotation (Line(points={{49.33864237029454,-174.980594539536},{29.338642370294536,-174.980594539536}},color={0,0,127}));
  connect(heaInd_d8a757c3.port_b2,TimeSerLoa_2561f077.ports_aHeaWat[1])
    annotation (Line(points={{37.496649781316535,-173.84912903096392},{57.496649781316535,-173.84912903096392}},color={0,0,127}));
  connect(pressure_source_13386826.ports[1], heaInd_d8a757c3.port_b2)
    annotation (Line(points={{-62.886306510264475,-761.6980626016584},{-42.886306510264475,-761.6980626016584},{-42.886306510264475,-741.6980626016584},{-42.886306510264475,-721.6980626016584},{-42.886306510264475,-701.6980626016584},{-42.886306510264475,-681.6980626016584},{-42.886306510264475,-661.6980626016584},{-42.886306510264475,-641.6980626016584},{-42.886306510264475,-621.6980626016584},{-42.886306510264475,-601.6980626016584},{-42.886306510264475,-581.6980626016584},{-42.886306510264475,-561.6980626016584},{-42.886306510264475,-541.6980626016584},{-42.886306510264475,-521.6980626016584},{-42.886306510264475,-501.6980626016584},{-42.886306510264475,-481.6980626016584},{-42.886306510264475,-461.6980626016584},{-42.886306510264475,-441.6980626016584},{-42.886306510264475,-421.6980626016584},{-42.886306510264475,-401.6980626016584},{-42.886306510264475,-381.6980626016584},{-42.886306510264475,-361.6980626016584},{-42.886306510264475,-341.6980626016584},{-42.886306510264475,-321.6980626016584},{-42.886306510264475,-301.6980626016584},{-42.886306510264475,-281.6980626016584},{-42.886306510264475,-261.6980626016584},{-42.886306510264475,-241.69806260165842},{-42.886306510264475,-221.69806260165842},{-42.886306510264475,-201.69806260165842},{-42.886306510264475,-181.69806260165842},{-22.886306510264475,-181.69806260165842},{-2.8863065102644754,-181.69806260165842},{17.113693489735525,-181.69806260165842}},color={0,0,127}));
  connect(THeaWatSet_13386826.y,heaInd_d8a757c3.TSetBuiSup)
    annotation (Line(points={{-29.164726983776454,-755.208866242456},{-9.164726983776447,-755.208866242456},{-9.164726983776447,-735.208866242456},{-9.164726983776447,-715.208866242456},{-9.164726983776447,-695.208866242456},{-9.164726983776447,-675.208866242456},{-9.164726983776447,-655.208866242456},{-9.164726983776447,-635.208866242456},{-9.164726983776447,-615.208866242456},{-9.164726983776447,-595.208866242456},{-9.164726983776447,-575.208866242456},{-9.164726983776447,-555.208866242456},{-9.164726983776447,-535.208866242456},{-9.164726983776447,-515.208866242456},{-9.164726983776447,-495.208866242456},{-9.164726983776447,-475.208866242456},{-9.164726983776447,-455.208866242456},{-9.164726983776447,-435.208866242456},{-9.164726983776447,-415.208866242456},{-9.164726983776447,-395.208866242456},{-9.164726983776447,-375.208866242456},{-9.164726983776447,-355.208866242456},{-9.164726983776447,-335.208866242456},{-9.164726983776447,-315.208866242456},{-9.164726983776447,-295.208866242456},{-9.164726983776447,-275.208866242456},{-9.164726983776447,-255.208866242456},{-9.164726983776447,-235.208866242456},{-9.164726983776447,-215.208866242456},{-9.164726983776447,-195.208866242456},{-9.164726983776447,-175.208866242456},{10.835273016223553,-175.208866242456}},color={0,0,127}));

  //
  // End Connect Statements for 13386826
  //



  //
  // Begin Connect Statements for ac6c2645
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_d69ee963.ports_bCon[13],heaInd_d8a757c3.port_a1)
    annotation (Line(points={{-11.851794726219552,722.7626851819728},{-11.851794726219552,702.7626851819728},{-11.851794726219552,682.7626851819728},{-11.851794726219552,662.7626851819728},{-11.851794726219552,642.7626851819728},{-11.851794726219552,622.7626851819728},{-11.851794726219552,602.7626851819728},{-11.851794726219552,582.7626851819728},{-11.851794726219552,562.7626851819728},{-11.851794726219552,542.7626851819728},{-11.851794726219552,522.7626851819728},{-11.851794726219552,502.76268518197276},{-11.851794726219552,482.76268518197276},{-11.851794726219552,462.76268518197276},{-11.851794726219552,442.76268518197276},{-11.851794726219552,422.76268518197276},{-11.851794726219552,402.76268518197276},{-11.851794726219552,382.76268518197276},{-11.851794726219552,362.76268518197276},{-11.851794726219552,342.76268518197276},{-11.851794726219552,322.76268518197276},{-11.851794726219552,302.76268518197276},{-11.851794726219552,282.76268518197276},{-11.851794726219552,262.76268518197276},{-11.851794726219552,242.76268518197276},{-11.851794726219552,222.76268518197276},{-11.851794726219552,202.76268518197276},{-11.851794726219552,182.76268518197276},{-11.851794726219552,162.76268518197276},{-11.851794726219552,142.76268518197276},{-11.851794726219552,122.76268518197276},{-11.851794726219552,102.76268518197276},{-11.851794726219552,82.76268518197276},{-11.851794726219552,62.762685181972756},{-11.851794726219552,42.762685181972756},{-11.851794726219552,22.762685181972756},{-11.851794726219552,2.7626851819727563},{-11.851794726219552,-17.237314818027244},{-11.851794726219552,-37.237314818027244},{-11.851794726219552,-57.237314818027244},{-11.851794726219552,-77.23731481802724},{-11.851794726219552,-97.23731481802724},{-11.851794726219552,-117.23731481802724},{-11.851794726219552,-137.23731481802724},{-11.851794726219552,-157.23731481802724},{-11.851794726219552,-177.23731481802724},{8.148205273780448,-177.23731481802724},{28.148205273780448,-177.23731481802724}},color={0,0,127}));
  connect(disNet_d69ee963.ports_aCon[13],heaInd_d8a757c3.port_b1)
    annotation (Line(points={{-15.231181244180533,727.0018981368078},{-15.231181244180533,707.0018981368078},{-15.231181244180533,687.0018981368078},{-15.231181244180533,667.0018981368078},{-15.231181244180533,647.0018981368078},{-15.231181244180533,627.0018981368078},{-15.231181244180533,607.0018981368078},{-15.231181244180533,587.0018981368078},{-15.231181244180533,567.0018981368078},{-15.231181244180533,547.0018981368078},{-15.231181244180533,527.0018981368078},{-15.231181244180533,507.00189813680777},{-15.231181244180533,487.00189813680777},{-15.231181244180533,467.00189813680777},{-15.231181244180533,447.00189813680777},{-15.231181244180533,427.00189813680777},{-15.231181244180533,407.00189813680777},{-15.231181244180533,387.00189813680777},{-15.231181244180533,367.00189813680777},{-15.231181244180533,347.00189813680777},{-15.231181244180533,327.00189813680777},{-15.231181244180533,307.00189813680777},{-15.231181244180533,287.00189813680777},{-15.231181244180533,267.00189813680777},{-15.231181244180533,247.00189813680777},{-15.231181244180533,227.00189813680777},{-15.231181244180533,207.00189813680777},{-15.231181244180533,187.00189813680777},{-15.231181244180533,167.00189813680777},{-15.231181244180533,147.00189813680777},{-15.231181244180533,127.00189813680777},{-15.231181244180533,107.00189813680777},{-15.231181244180533,87.00189813680777},{-15.231181244180533,67.00189813680777},{-15.231181244180533,47.00189813680777},{-15.231181244180533,27.001898136807768},{-15.231181244180533,7.0018981368077675},{-15.231181244180533,-12.998101863192232},{-15.231181244180533,-32.99810186319223},{-15.231181244180533,-52.99810186319223},{-15.231181244180533,-72.99810186319223},{-15.231181244180533,-92.99810186319223},{-15.231181244180533,-112.99810186319223},{-15.231181244180533,-132.99810186319223},{-15.231181244180533,-152.99810186319223},{-15.231181244180533,-172.99810186319223},{4.768818755819467,-172.99810186319223},{24.768818755819467,-172.99810186319223}},color={0,0,127}));

  //
  // End Connect Statements for ac6c2645
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