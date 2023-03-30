within doe_small_demo_high_eff.Districts;
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
  // Begin Model Instance for disNet_fb10f181
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_fb10f181=3;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_fb10f181=sum({
    cooInd_c0fbdcab.mDis_flow_nominal,
  cooInd_abec545a.mDis_flow_nominal,
  cooInd_5d815c96.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_fb10f181[nBui_disNet_fb10f181]={
    cooInd_c0fbdcab.mDis_flow_nominal,
  cooInd_abec545a.mDis_flow_nominal,
  cooInd_5d815c96.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_fb10f181[nBui_disNet_fb10f181](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_fb10f181*0.1},
    fill(
      dp_nominal_disNet_fb10f181*0.9/(nBui_disNet_fb10f181-1),
      nBui_disNet_fb10f181-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_fb10f181=dpSetPoi_disNet_fb10f181+nBui_disNet_fb10f181*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_fb10f181=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_fb10f181(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_fb10f181,
    iConDpSen=nBui_disNet_fb10f181,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_fb10f181,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_fb10f181,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_fb10f181)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,180.0},{-10.0,190.0}})));
  //
  // End Model Instance for disNet_fb10f181
  //


  
  //
  // Begin Model Instance for cooPla_626938b5
  // Source template: /model_connectors/plants/templates/CoolingPlant_Instance.mopt
  //
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal_cooPla_626938b5=cooPla_626938b5.numChi*(cooPla_626938b5.perChi.mEva_flow_nominal)
    "Nominal chilled water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal_cooPla_626938b5=cooPla_626938b5.perChi.mCon_flow_nominal
    "Nominal condenser water mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dpCHW_nominal_cooPla_626938b5=44.8*1000
    "Nominal chilled water side pressure";
  parameter Modelica.Units.SI.PressureDifference dpCW_nominal_cooPla_626938b5=46.2*1000
    "Nominal condenser water side pressure";
  parameter Modelica.Units.SI.Power QEva_nominal_cooPla_626938b5=mCHW_flow_nominal_cooPla_626938b5*4200*(5-14)
    "Nominal cooling capaciaty (Negative means cooling)";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_cooPla_626938b5=0.2*mCHW_flow_nominal_cooPla_626938b5/cooPla_626938b5.numChi
    "Minimum mass flow rate of single chiller";
  // control settings
  parameter Modelica.Units.SI.Pressure dpSetPoi_cooPla_626938b5=70000
    "Differential pressure setpoint";
  parameter Modelica.Units.SI.Pressure pumDP_cooPla_626938b5=dpCHW_nominal_cooPla_626938b5+dpSetPoi_cooPla_626938b5+200000;
  parameter Modelica.Units.SI.Time tWai_cooPla_626938b5=30
    "Waiting time";
  // pumps
  parameter Buildings.Fluid.Movers.Data.Generic perCHWPum_cooPla_626938b5(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=((mCHW_flow_nominal_cooPla_626938b5/cooPla_626938b5.numChi)/1000)*{0.1,1,1.2},
      dp=pumDP_cooPla_626938b5*{1.2,1,0.1}))
    "Performance data for chilled water pumps";
  parameter Buildings.Fluid.Movers.Data.Generic perCWPum_cooPla_626938b5(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mCW_flow_nominal_cooPla_626938b5/1000*{0.2,0.6,1.0,1.2},
      dp=(dpCW_nominal_cooPla_626938b5+60000+6000)*{1.2,1.1,1.0,0.6}))
    "Performance data for condenser water pumps";


  Modelica.Blocks.Sources.RealExpression TSetChiWatDis_cooPla_626938b5(
    y=5+273.15)
    "Chilled water supply temperature set point on district level."
    annotation (Placement(transformation(extent={{10.0,-190.0},{30.0,-170.0}})));
  Modelica.Blocks.Sources.BooleanConstant on_cooPla_626938b5
    "On signal of the plant"
    annotation (Placement(transformation(extent={{50.0,-190.0},{70.0,-170.0}})));

  doe_small_demo_high_eff.Plants.CentralCoolingPlant cooPla_626938b5(
    redeclare Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19EX_5208kW_6_88COP_Vanes perChi,
    perCHWPum=perCHWPum_cooPla_626938b5,
    perCWPum=perCWPum_cooPla_626938b5,
    mCHW_flow_nominal=mCHW_flow_nominal_cooPla_626938b5,
    dpCHW_nominal=dpCHW_nominal_cooPla_626938b5,
    QEva_nominal=QEva_nominal_cooPla_626938b5,
    mMin_flow=mMin_flow_cooPla_626938b5,
    mCW_flow_nominal=mCW_flow_nominal_cooPla_626938b5,
    dpCW_nominal=dpCW_nominal_cooPla_626938b5,
    TAirInWB_nominal=298.7,
    TCW_nominal=308.15,
    TMin=288.15,
    tWai=tWai_cooPla_626938b5,
    dpSetPoi=dpSetPoi_cooPla_626938b5
    )
    "District cooling plant."
    annotation (Placement(transformation(extent={{-70.0,170.0},{-50.0,190.0}})));
  //
  // End Model Instance for cooPla_626938b5
  //


  
  //
  // Begin Model Instance for disNet_fc011ebe
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_fc011ebe=3;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_fc011ebe=sum({
    heaInd_b4ec78f8.mDis_flow_nominal,
  heaInd_c8e7769e.mDis_flow_nominal,
  heaInd_3629ff40.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_fc011ebe[nBui_disNet_fc011ebe]={
    heaInd_b4ec78f8.mDis_flow_nominal,
  heaInd_c8e7769e.mDis_flow_nominal,
  heaInd_3629ff40.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_fc011ebe[nBui_disNet_fc011ebe](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_fc011ebe*0.1},
    fill(
      dp_nominal_disNet_fc011ebe*0.9/(nBui_disNet_fc011ebe-1),
      nBui_disNet_fc011ebe-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_fc011ebe=dpSetPoi_disNet_fc011ebe+nBui_disNet_fc011ebe*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_fc011ebe=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_fc011ebe(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_fc011ebe,
    iConDpSen=nBui_disNet_fc011ebe,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_fc011ebe,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_fc011ebe,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_fc011ebe)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,140.0},{-10.0,150.0}})));
  //
  // End Model Instance for disNet_fc011ebe
  //


  
  //
  // Begin Model Instance for heaPla18fc6d5f
  // Source template: /model_connectors/plants/templates/HeatingPlant_Instance.mopt
  //
  // heating plant instance
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal_heaPla18fc6d5f=mBoi_flow_nominal_heaPla18fc6d5f*heaPla18fc6d5f.numBoi
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal_heaPla18fc6d5f=QBoi_nominal_heaPla18fc6d5f/(4200*heaPla18fc6d5f.delT_nominal)
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.Power QBoi_nominal_heaPla18fc6d5f=Q_flow_nominal_heaPla18fc6d5f/heaPla18fc6d5f.numBoi
    "Nominal heating capaciaty";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_heaPla18fc6d5f=1000000*2
    "Heating load";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_heaPla18fc6d5f=0.2*mBoi_flow_nominal_heaPla18fc6d5f
    "Minimum mass flow rate of single boiler";
  // controls
  parameter Modelica.Units.SI.Pressure pumDP=(heaPla18fc6d5f.dpBoi_nominal+dpSetPoi_disNet_fc011ebe+50000)
    "Heating water pump pressure drop";
  parameter Modelica.Units.SI.Time tWai_heaPla18fc6d5f=30
    "Waiting time";
  parameter Buildings.Fluid.Movers.Data.Generic perHWPum_heaPla18fc6d5f(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mBoi_flow_nominal_heaPla18fc6d5f/1000*{0.1,1.1},
      dp=pumDP*{1.1,0.1}))
    "Performance data for heating water pumps";

  doe_small_demo_high_eff.Plants.CentralHeatingPlant heaPla18fc6d5f(
    perHWPum=perHWPum_heaPla18fc6d5f,
    mHW_flow_nominal=mHW_flow_nominal_heaPla18fc6d5f,
    QBoi_flow_nominal=QBoi_nominal_heaPla18fc6d5f,
    mMin_flow=mMin_flow_heaPla18fc6d5f,
    mBoi_flow_nominal=mBoi_flow_nominal_heaPla18fc6d5f,
    dpBoi_nominal=10000,
    delT_nominal(
      displayUnit="degC")=15,
    tWai=tWai_heaPla18fc6d5f,
    // TODO: we're currently grabbing dpSetPoi from the Network instance -- need feedback to determine if that's the proper "home" for it
    dpSetPoi=dpSetPoi_disNet_fc011ebe
    )
    "District heating plant."
    annotation (Placement(transformation(extent={{-70.0,130.0},{-50.0,150.0}})));
  //
  // End Model Instance for heaPla18fc6d5f
  //


  
  //
  // Begin Model Instance for TimeSerLoa_da667618
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  doe_small_demo_high_eff.Loads.B2.TimeSeriesBuilding TimeSerLoa_da667618(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,170.0},{70.0,190.0}})));
  //
  // End Model Instance for TimeSerLoa_da667618
  //


  
  //
  // Begin Model Instance for cooInd_c0fbdcab
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  doe_small_demo_high_eff.Substations.CoolingIndirect_2 cooInd_c0fbdcab(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_c58ac0fd,
    mBui_flow_nominal=mBui_flow_nominal_c58ac0fd,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_c58ac0fd,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,170.0},{30.0,190.0}})));
  //
  // End Model Instance for cooInd_c0fbdcab
  //


  
  //
  // Begin Model Instance for heaInd_b4ec78f8
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  doe_small_demo_high_eff.Substations.HeatingIndirect_2 heaInd_b4ec78f8(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_7768e40f,
    mBui_flow_nominal=mBui_flow_nominal_7768e40f,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_7768e40f,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,130.0},{30.0,150.0}})));
  //
  // End Model Instance for heaInd_b4ec78f8
  //


  
  //
  // Begin Model Instance for TimeSerLoa_13ecd099
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  doe_small_demo_high_eff.Loads.B6.TimeSeriesBuilding TimeSerLoa_13ecd099(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,90.0},{70.0,110.0}})));
  //
  // End Model Instance for TimeSerLoa_13ecd099
  //


  
  //
  // Begin Model Instance for cooInd_abec545a
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  doe_small_demo_high_eff.Substations.CoolingIndirect_6 cooInd_abec545a(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_cfcd4cad,
    mBui_flow_nominal=mBui_flow_nominal_cfcd4cad,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_cfcd4cad,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,90.0},{30.0,110.0}})));
  //
  // End Model Instance for cooInd_abec545a
  //


  
  //
  // Begin Model Instance for heaInd_c8e7769e
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  doe_small_demo_high_eff.Substations.HeatingIndirect_6 heaInd_c8e7769e(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_0d8ae983,
    mBui_flow_nominal=mBui_flow_nominal_0d8ae983,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_0d8ae983,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,50.0},{30.0,70.0}})));
  //
  // End Model Instance for heaInd_c8e7769e
  //


  
  //
  // Begin Model Instance for TimeSerLoa_95ec8ee0
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  doe_small_demo_high_eff.Loads.B11.TimeSeriesBuilding TimeSerLoa_95ec8ee0(
    
    T_aHeaWat_nominal(displayUnit="K")=318.15,
    T_aChiWat_nominal(displayUnit="K")=280.15,
    delTAirCoo(displayUnit="degC")=10,
    delTAirHea(displayUnit="degC")=20,
    k=0.1,
    Ti=120
    
    )
    "Building model integrating multiple time series thermal zones."
    annotation (Placement(transformation(extent={{50.0,10.0},{70.0,30.0}})));
  //
  // End Model Instance for TimeSerLoa_95ec8ee0
  //


  
  //
  // Begin Model Instance for cooInd_5d815c96
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  doe_small_demo_high_eff.Substations.CoolingIndirect_11 cooInd_5d815c96(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_6edb1bef,
    mBui_flow_nominal=mBui_flow_nominal_6edb1bef,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_6edb1bef,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,10.0},{30.0,30.0}})));
  //
  // End Model Instance for cooInd_5d815c96
  //


  
  //
  // Begin Model Instance for heaInd_3629ff40
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  doe_small_demo_high_eff.Substations.HeatingIndirect_11 heaInd_3629ff40(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_b17d05bd,
    mBui_flow_nominal=mBui_flow_nominal_b17d05bd,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_b17d05bd,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,-30.0},{30.0,-10.0}})));
  //
  // End Model Instance for heaInd_3629ff40
  //


  

  // Model dependencies

  //
  // Begin Component Definitions for 1934b1b1
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ComponentDefinitions.mopt
  //
  // No components for pipe and cooling plant

  //
  // End Component Definitions for 1934b1b1
  //



  //
  // Begin Component Definitions for a7e8c1d6
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ComponentDefinitions.mopt
  //
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.BooleanConstant mPum_flow_a7e8c1d6(
    k=true)
    "Total heating water pump mass flow rate"
    annotation (Placement(transformation(extent={{-70.0,-70.0},{-50.0,-50.0}})));
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.RealExpression TDisSetHeaWat_a7e8c1d6(
    each y=273.15+54)
    "District side heating water supply temperature set point."
    annotation (Placement(transformation(extent={{-30.0,-70.0},{-10.0,-50.0}})));

  //
  // End Component Definitions for a7e8c1d6
  //



  //
  // Begin Component Definitions for c58ac0fd
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_c58ac0fd=TimeSerLoa_da667618.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_c58ac0fd=TimeSerLoa_da667618.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_c58ac0fd=-1*(TimeSerLoa_da667618.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_c58ac0fd(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-70.0},{30.0,-50.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_c58ac0fd(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-70.0},{70.0,-50.0}})));

  //
  // End Component Definitions for c58ac0fd
  //



  //
  // Begin Component Definitions for 32275884
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 32275884
  //



  //
  // Begin Component Definitions for 7768e40f
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_7768e40f=TimeSerLoa_da667618.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_7768e40f=TimeSerLoa_da667618.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_7768e40f=(TimeSerLoa_da667618.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_7768e40f(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-110.0},{-50.0,-90.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_7768e40f(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-110.0},{-10.0,-90.0}})));

  //
  // End Component Definitions for 7768e40f
  //



  //
  // Begin Component Definitions for 37621444
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 37621444
  //



  //
  // Begin Component Definitions for cfcd4cad
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_cfcd4cad=TimeSerLoa_13ecd099.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_cfcd4cad=TimeSerLoa_13ecd099.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_cfcd4cad=-1*(TimeSerLoa_13ecd099.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_cfcd4cad(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-110.0},{30.0,-90.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_cfcd4cad(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-110.0},{70.0,-90.0}})));

  //
  // End Component Definitions for cfcd4cad
  //



  //
  // Begin Component Definitions for 90f411e3
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 90f411e3
  //



  //
  // Begin Component Definitions for 0d8ae983
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_0d8ae983=TimeSerLoa_13ecd099.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_0d8ae983=TimeSerLoa_13ecd099.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_0d8ae983=(TimeSerLoa_13ecd099.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_0d8ae983(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-150.0},{-50.0,-130.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_0d8ae983(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-150.0},{-10.0,-130.0}})));

  //
  // End Component Definitions for 0d8ae983
  //



  //
  // Begin Component Definitions for 636f7601
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 636f7601
  //



  //
  // Begin Component Definitions for 6edb1bef
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_6edb1bef=TimeSerLoa_95ec8ee0.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_6edb1bef=TimeSerLoa_95ec8ee0.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_6edb1bef=-1*(TimeSerLoa_95ec8ee0.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_6edb1bef(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-150.0},{30.0,-130.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_6edb1bef(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-150.0},{70.0,-130.0}})));

  //
  // End Component Definitions for 6edb1bef
  //



  //
  // Begin Component Definitions for 658a28a6
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 658a28a6
  //



  //
  // Begin Component Definitions for b17d05bd
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_b17d05bd=TimeSerLoa_95ec8ee0.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_b17d05bd=TimeSerLoa_95ec8ee0.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_b17d05bd=(TimeSerLoa_95ec8ee0.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_b17d05bd(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-190.0},{-50.0,-170.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_b17d05bd(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-190.0},{-10.0,-170.0}})));

  //
  // End Component Definitions for b17d05bd
  //



  //
  // Begin Component Definitions for 4718484a
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 4718484a
  //



equation
  // Connections

  //
  // Begin Connect Statements for 1934b1b1
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ConnectStatements.mopt
  //

  // TODO: these connect statements shouldn't be here, they are plant specific
  // but since we can't currently make connect statements for single systems, this is what we've got
  connect(on_cooPla_626938b5.y,cooPla_626938b5.on)
    annotation (Line(points={{64.83921270589536,-169.2390567896203},{44.83921270589536,-169.2390567896203},{44.83921270589536,-149.2390567896203},{44.83921270589536,-129.2390567896203},{44.83921270589536,-109.23905678962029},{44.83921270589536,-89.23905678962029},{44.83921270589536,-69.23905678962029},{44.83921270589536,-49.23905678962029},{44.83921270589536,-29.23905678962032},{44.83921270589536,-9.23905678962032},{44.83921270589536,10.76094321037968},{44.83921270589536,30.76094321037968},{44.83921270589536,50.76094321037968},{44.83921270589536,70.76094321037968},{44.83921270589536,90.76094321037968},{44.83921270589536,110.76094321037968},{44.83921270589536,130.76094321037968},{44.83921270589536,150.76094321037968},{24.83921270589535,150.76094321037968},{4.839212705895349,150.76094321037968},{-15.16078729410465,150.76094321037968},{-35.160787294104644,150.76094321037968},{-35.160787294104644,170.76094321037968},{-55.160787294104644,170.76094321037968}},color={0,0,127}));
  connect(TSetChiWatDis_cooPla_626938b5.y,cooPla_626938b5.TCHWSupSet)
    annotation (Line(points={{10.053505948803874,-157.10704196288924},{-9.946494051196126,-157.10704196288924},{-9.946494051196126,-137.10704196288924},{-9.946494051196126,-117.10704196288924},{-9.946494051196126,-97.10704196288924},{-9.946494051196126,-77.10704196288924},{-9.946494051196126,-57.10704196288924},{-9.946494051196126,-37.10704196288927},{-9.946494051196126,-17.10704196288927},{-9.946494051196126,2.8929580371107306},{-9.946494051196126,22.89295803711073},{-9.946494051196126,42.89295803711073},{-9.946494051196126,62.89295803711073},{-9.946494051196126,82.89295803711073},{-9.946494051196126,102.89295803711073},{-9.946494051196126,122.89295803711073},{-9.946494051196126,142.89295803711073},{-9.946494051196126,162.89295803711073},{-29.946494051196126,162.89295803711073},{-49.946494051196126,162.89295803711073},{-49.946494051196126,182.89295803711073},{-69.94649405119613,182.89295803711073}},color={0,0,127}));

  connect(disNet_fb10f181.port_bDisRet,cooPla_626938b5.port_a)
    annotation (Line(points={{-36.723958130089464,187.3873838329513},{-56.723958130089464,187.3873838329513}},color={0,0,127}));
  connect(cooPla_626938b5.port_b,disNet_fb10f181.port_aDisSup)
    annotation (Line(points={{-36.667833709022176,189.9012487379945},{-16.667833709022176,189.9012487379945}},color={0,0,127}));
  connect(disNet_fb10f181.dp,cooPla_626938b5.dpMea)
    annotation (Line(points={{-32.95252103408545,177.47779342031743},{-52.95252103408545,177.47779342031743}},color={0,0,127}));

  //
  // End Connect Statements for 1934b1b1
  //



  //
  // Begin Connect Statements for a7e8c1d6
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ConnectStatements.mopt
  //

  connect(heaPla18fc6d5f.port_a,disNet_fc011ebe.port_bDisRet)
    annotation (Line(points={{-40.87670891189937,138.32698113110843},{-20.87670891189937,138.32698113110843}},color={0,0,127}));
  connect(disNet_fc011ebe.dp,heaPla18fc6d5f.dpMea)
    annotation (Line(points={{-38.98230654085196,145.5730518206247},{-58.98230654085196,145.5730518206247}},color={0,0,127}));
  connect(heaPla18fc6d5f.port_b,disNet_fc011ebe.port_aDisSup)
    annotation (Line(points={{-38.88324611664499,148.50890006585902},{-18.883246116644983,148.50890006585902}},color={0,0,127}));
  connect(mPum_flow_a7e8c1d6.y,heaPla18fc6d5f.on)
    annotation (Line(points={{-68.27871000157562,-40.277529685008744},{-68.27871000157562,-20.277529685008744},{-68.27871000157562,-0.2775296850087443},{-68.27871000157562,19.722470314991256},{-68.27871000157562,39.722470314991256},{-68.27871000157562,59.722470314991256},{-68.27871000157562,79.72247031499126},{-68.27871000157562,99.72247031499127},{-68.27871000157562,119.72247031499127},{-68.27871000157562,139.72247031499126}},color={0,0,127}));
  connect(TDisSetHeaWat_a7e8c1d6.y,heaPla18fc6d5f.THeaSet)
    annotation (Line(points={{-13.763845717049719,-42.089758769391665},{-13.763845717049719,-22.089758769391665},{-13.763845717049719,-2.089758769391665},{-13.763845717049719,17.910241230608335},{-13.763845717049719,37.910241230608335},{-13.763845717049719,57.910241230608335},{-13.763845717049719,77.91024123060834},{-13.763845717049719,97.91024123060834},{-13.763845717049719,117.91024123060834},{-33.76384571704972,117.91024123060834},{-33.76384571704972,137.91024123060834},{-53.76384571704972,137.91024123060834}},color={0,0,127}));

  //
  // End Connect Statements for a7e8c1d6
  //



  //
  // Begin Connect Statements for c58ac0fd
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_da667618.ports_bChiWat[1], cooInd_c0fbdcab.port_a2)
    annotation (Line(points={{39.26892954738216,186.09651519696556},{19.268929547382157,186.09651519696556}},color={0,0,127}));
  connect(cooInd_c0fbdcab.port_b2,TimeSerLoa_da667618.ports_aChiWat[1])
    annotation (Line(points={{31.939144645766703,178.65179243214217},{51.9391446457667,178.65179243214217}},color={0,0,127}));
  connect(pressure_source_c58ac0fd.ports[1], cooInd_c0fbdcab.port_b2)
    annotation (Line(points={{28.32586459356523,-41.6267524996797},{8.325864593565228,-41.6267524996797},{8.325864593565228,-21.626752499679696},{8.325864593565228,-1.6267524996796965},{8.325864593565228,18.373247500320304},{8.325864593565228,38.3732475003203},{8.325864593565228,58.3732475003203},{8.325864593565228,78.3732475003203},{8.325864593565228,98.3732475003203},{8.325864593565228,118.3732475003203},{8.325864593565228,138.3732475003203},{8.325864593565228,158.3732475003203},{8.325864593565228,178.3732475003203},{28.32586459356523,178.3732475003203}},color={0,0,127}));
  connect(TChiWatSet_c58ac0fd.y,cooInd_c0fbdcab.TSetBuiSup)
    annotation (Line(points={{66.18489308511852,-34.33465482438271},{66.18489308511852,-14.33465482438271},{66.18489308511852,5.66534517561729},{46.18489308511852,5.66534517561729},{46.18489308511852,25.66534517561729},{46.18489308511852,45.66534517561729},{46.18489308511852,65.66534517561729},{46.18489308511852,85.6653451756173},{46.18489308511852,105.6653451756173},{46.18489308511852,125.6653451756173},{46.18489308511852,145.6653451756173},{46.18489308511852,165.6653451756173},{46.18489308511852,185.6653451756173},{66.18489308511852,185.6653451756173}},color={0,0,127}));

  //
  // End Connect Statements for c58ac0fd
  //



  //
  // Begin Connect Statements for 32275884
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_fb10f181.ports_bCon[1],cooInd_c0fbdcab.port_a1)
    annotation (Line(points={{6.710708100493463,181.24324880405663},{26.710708100493463,181.24324880405663}},color={0,0,127}));
  connect(disNet_fb10f181.ports_aCon[1],cooInd_c0fbdcab.port_b1)
    annotation (Line(points={{-6.683912773631093,173.39629291107093},{13.316087226368907,173.39629291107093}},color={0,0,127}));

  //
  // End Connect Statements for 32275884
  //



  //
  // Begin Connect Statements for 7768e40f
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_da667618.ports_bHeaWat[1], heaInd_b4ec78f8.port_a2)
    annotation (Line(points={{69.35708631739647,157.45319162242052},{69.35708631739647,137.45319162242052},{49.357086317396465,137.45319162242052},{29.357086317396465,137.45319162242052}},color={0,0,127}));
  connect(heaInd_b4ec78f8.port_b2,TimeSerLoa_da667618.ports_aHeaWat[1])
    annotation (Line(points={{16.656351725327866,156.61023937470705},{36.656351725327866,156.61023937470705},{36.656351725327866,176.61023937470705},{56.65635172532785,176.61023937470705}},color={0,0,127}));
  connect(pressure_source_7768e40f.ports[1], heaInd_b4ec78f8.port_b2)
    annotation (Line(points={{-60.20902388743358,-77.0738921778372},{-40.20902388743358,-77.0738921778372},{-40.20902388743358,-57.073892177837195},{-40.20902388743358,-37.073892177837195},{-40.20902388743358,-17.073892177837195},{-40.20902388743358,2.9261078221628054},{-40.20902388743358,22.926107822162805},{-40.20902388743358,42.926107822162805},{-40.20902388743358,62.926107822162805},{-40.20902388743358,82.92610782216279},{-40.20902388743358,102.92610782216279},{-40.20902388743358,122.92610782216279},{-20.209023887433574,122.92610782216279},{-0.20902388743357392,122.92610782216279},{-0.20902388743357392,142.9261078221628},{19.790976112566426,142.9261078221628}},color={0,0,127}));
  connect(THeaWatSet_7768e40f.y,heaInd_b4ec78f8.TSetBuiSup)
    annotation (Line(points={{-12.39435947539441,-72.57059750533267},{7.60564052460559,-72.57059750533267},{7.60564052460559,-52.57059750533267},{7.60564052460559,-32.57059750533264},{7.60564052460559,-12.570597505332643},{7.60564052460559,7.429402494667357},{7.60564052460559,27.429402494667357},{7.60564052460559,47.42940249466736},{7.60564052460559,67.42940249466736},{7.60564052460559,87.42940249466736},{7.60564052460559,107.42940249466736},{7.60564052460559,127.42940249466736},{7.60564052460559,147.42940249466736},{27.60564052460559,147.42940249466736}},color={0,0,127}));

  //
  // End Connect Statements for 7768e40f
  //



  //
  // Begin Connect Statements for 37621444
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_fc011ebe.ports_bCon[1],heaInd_b4ec78f8.port_a1)
    annotation (Line(points={{3.4411189928416235,147.56602897332706},{23.441118992841623,147.56602897332706}},color={0,0,127}));
  connect(disNet_fc011ebe.ports_aCon[1],heaInd_b4ec78f8.port_b1)
    annotation (Line(points={{3.5485158136851567,131.3506793332253},{23.548515813685157,131.3506793332253}},color={0,0,127}));

  //
  // End Connect Statements for 37621444
  //



  //
  // Begin Connect Statements for cfcd4cad
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_13ecd099.ports_bChiWat[1], cooInd_abec545a.port_a2)
    annotation (Line(points={{41.46049635778175,103.83708448364527},{21.460496357781764,103.83708448364527}},color={0,0,127}));
  connect(cooInd_abec545a.port_b2,TimeSerLoa_13ecd099.ports_aChiWat[1])
    annotation (Line(points={{35.65481413950329,104.9285444831321},{55.65481413950329,104.9285444831321}},color={0,0,127}));
  connect(pressure_source_cfcd4cad.ports[1], cooInd_abec545a.port_b2)
    annotation (Line(points={{18.049550349846612,-76.39412174267034},{-1.950449650153388,-76.39412174267034},{-1.950449650153388,-56.394121742670336},{-1.950449650153388,-36.394121742670364},{-1.950449650153388,-16.394121742670364},{-1.950449650153388,3.6058782573296355},{-1.950449650153388,23.605878257329636},{-1.950449650153388,43.605878257329636},{-1.950449650153388,63.605878257329636},{-1.950449650153388,83.60587825732964},{-1.950449650153388,103.60587825732964},{18.049550349846612,103.60587825732964}},color={0,0,127}));
  connect(TChiWatSet_cfcd4cad.y,cooInd_abec545a.TSetBuiSup)
    annotation (Line(points={{54.79059963452505,-75.99479121116394},{34.79059963452505,-75.99479121116394},{34.79059963452505,-55.99479121116394},{34.79059963452505,-35.99479121116394},{34.79059963452505,-15.994791211163943},{34.79059963452505,4.0052087888360575},{34.79059963452505,24.005208788836057},{34.79059963452505,44.00520878883606},{34.79059963452505,64.00520878883606},{34.79059963452505,84.00520878883607},{34.79059963452505,104.00520878883607},{54.79059963452505,104.00520878883607}},color={0,0,127}));

  //
  // End Connect Statements for cfcd4cad
  //



  //
  // Begin Connect Statements for 90f411e3
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_fb10f181.ports_bCon[2],cooInd_abec545a.port_a1)
    annotation (Line(points={{-27.607391463616395,151.73479569385353},{-7.607391463616395,151.73479569385353},{-7.607391463616395,131.73479569385353},{-7.607391463616395,111.73479569385353},{-7.607391463616395,91.73479569385353},{12.392608536383605,91.73479569385353}},color={0,0,127}));
  connect(disNet_fb10f181.ports_aCon[2],cooInd_abec545a.port_b1)
    annotation (Line(points={{-28.04153274831812,169.4898442479641},{-8.041532748318119,169.4898442479641},{-8.041532748318119,149.4898442479641},{-8.041532748318119,129.4898442479641},{-8.041532748318119,109.4898442479641},{11.958467251681881,109.4898442479641}},color={0,0,127}));

  //
  // End Connect Statements for 90f411e3
  //



  //
  // Begin Connect Statements for 0d8ae983
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_13ecd099.ports_bHeaWat[1], heaInd_c8e7769e.port_a2)
    annotation (Line(points={{50.6993187716256,73.54277977661954},{50.6993187716256,53.54277977661954},{30.699318771625613,53.54277977661954},{10.699318771625613,53.54277977661954}},color={0,0,127}));
  connect(heaInd_c8e7769e.port_b2,TimeSerLoa_13ecd099.ports_aHeaWat[1])
    annotation (Line(points={{27.43387379340969,74.01884023592672},{47.4338737934097,74.01884023592672},{47.4338737934097,94.01884023592672},{67.4338737934097,94.01884023592672}},color={0,0,127}));
  connect(pressure_source_0d8ae983.ports[1], heaInd_c8e7769e.port_b2)
    annotation (Line(points={{-62.173802962662236,-120.9626932971147},{-42.173802962662236,-120.9626932971147},{-42.173802962662236,-100.9626932971147},{-42.173802962662236,-80.9626932971147},{-42.173802962662236,-60.9626932971147},{-42.173802962662236,-40.9626932971147},{-42.173802962662236,-20.962693297114697},{-42.173802962662236,-0.9626932971146971},{-42.173802962662236,19.037306702885303},{-42.173802962662236,39.0373067028853},{-42.173802962662236,59.0373067028853},{-22.173802962662236,59.0373067028853},{-2.1738029626622364,59.0373067028853},{17.826197037337764,59.0373067028853}},color={0,0,127}));
  connect(THeaWatSet_0d8ae983.y,heaInd_c8e7769e.TSetBuiSup)
    annotation (Line(points={{-16.009977978611573,-129.2641367479593},{3.9900220213884268,-129.2641367479593},{3.9900220213884268,-109.2641367479593},{3.9900220213884268,-89.2641367479593},{3.9900220213884268,-69.2641367479593},{3.9900220213884268,-49.2641367479593},{3.9900220213884268,-29.2641367479593},{3.9900220213884268,-9.264136747959299},{3.9900220213884268,10.735863252040701},{3.9900220213884268,30.7358632520407},{3.9900220213884268,50.7358632520407},{23.990022021388427,50.7358632520407}},color={0,0,127}));

  //
  // End Connect Statements for 0d8ae983
  //



  //
  // Begin Connect Statements for 636f7601
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_fc011ebe.ports_bCon[2],heaInd_c8e7769e.port_a1)
    annotation (Line(points={{-16.485327855495882,116.18272593081944},{-16.485327855495882,96.18272593081944},{-16.485327855495882,76.18272593081946},{-16.485327855495882,56.18272593081946},{3.514672144504118,56.18272593081946},{23.514672144504118,56.18272593081946}},color={0,0,127}));
  connect(disNet_fc011ebe.ports_aCon[2],heaInd_c8e7769e.port_b1)
    annotation (Line(points={{-16.287377841310416,110.72656098469864},{-16.287377841310416,90.72656098469864},{-16.287377841310416,70.72656098469864},{-16.287377841310416,50.72656098469864},{3.712622158689584,50.72656098469864},{23.712622158689584,50.72656098469864}},color={0,0,127}));

  //
  // End Connect Statements for 636f7601
  //



  //
  // Begin Connect Statements for 6edb1bef
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_95ec8ee0.ports_bChiWat[1], cooInd_5d815c96.port_a2)
    annotation (Line(points={{30.89110491003956,15.872984635684332},{10.891104910039559,15.872984635684332}},color={0,0,127}));
  connect(cooInd_5d815c96.port_b2,TimeSerLoa_95ec8ee0.ports_aChiWat[1])
    annotation (Line(points={{34.42602564320448,29.685631318496547},{54.42602564320447,29.685631318496547}},color={0,0,127}));
  connect(pressure_source_6edb1bef.ports[1], cooInd_5d815c96.port_b2)
    annotation (Line(points={{18.15707628943545,-118.96584746482938},{-1.8429237105645484,-118.96584746482938},{-1.8429237105645484,-98.96584746482938},{-1.8429237105645484,-78.96584746482938},{-1.8429237105645484,-58.96584746482938},{-1.8429237105645484,-38.96584746482935},{-1.8429237105645484,-18.965847464829352},{-1.8429237105645484,1.034152535170648},{-1.8429237105645484,21.034152535170648},{18.15707628943545,21.034152535170648}},color={0,0,127}));
  connect(TChiWatSet_6edb1bef.y,cooInd_5d815c96.TSetBuiSup)
    annotation (Line(points={{51.80454354594269,-129.80108616149238},{31.804543545942707,-129.80108616149238},{31.804543545942707,-109.80108616149238},{31.804543545942707,-89.80108616149238},{31.804543545942707,-69.80108616149238},{31.804543545942707,-49.80108616149238},{31.804543545942707,-29.80108616149238},{31.804543545942707,-9.801086161492378},{31.804543545942707,10.198913838507622},{51.80454354594269,10.198913838507622}},color={0,0,127}));

  //
  // End Connect Statements for 6edb1bef
  //



  //
  // Begin Connect Statements for 658a28a6
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_fb10f181.ports_bCon[3],cooInd_5d815c96.port_a1)
    annotation (Line(points={{-12.81256081777127,155.26038757301805},{7.187439182228729,155.26038757301805},{7.187439182228729,135.26038757301805},{7.187439182228729,115.26038757301805},{7.187439182228729,95.26038757301805},{7.187439182228729,75.26038757301805},{7.187439182228729,55.26038757301805},{7.187439182228729,35.26038757301805},{7.187439182228729,15.26038757301805},{27.18743918222873,15.26038757301805}},color={0,0,127}));
  connect(disNet_fb10f181.ports_aCon[3],cooInd_5d815c96.port_b1)
    annotation (Line(points={{-14.354315614152227,151.9195933640719},{5.6456843858477725,151.9195933640719},{5.6456843858477725,131.9195933640719},{5.6456843858477725,111.91959336407187},{5.6456843858477725,91.91959336407187},{5.6456843858477725,71.91959336407189},{5.6456843858477725,51.919593364071886},{5.6456843858477725,31.919593364071886},{5.6456843858477725,11.919593364071886},{25.645684385847773,11.919593364071886}},color={0,0,127}));

  //
  // End Connect Statements for 658a28a6
  //



  //
  // Begin Connect Statements for b17d05bd
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_95ec8ee0.ports_bHeaWat[1], heaInd_3629ff40.port_a2)
    annotation (Line(points={{53.50060224955669,-7.64341713516032},{53.50060224955669,-27.64341713516032},{33.50060224955668,-27.64341713516032},{13.500602249556678,-27.64341713516032}},color={0,0,127}));
  connect(heaInd_3629ff40.port_b2,TimeSerLoa_95ec8ee0.ports_aHeaWat[1])
    annotation (Line(points={{21.202080781225177,7.601776845950724},{41.20208078122516,7.601776845950724},{41.20208078122516,27.601776845950724},{61.20208078122516,27.601776845950724}},color={0,0,127}));
  connect(pressure_source_b17d05bd.ports[1], heaInd_3629ff40.port_b2)
    annotation (Line(points={{-63.499377431803964,-168.74942637354565},{-43.499377431803964,-168.74942637354565},{-43.499377431803964,-148.74942637354565},{-43.499377431803964,-128.74942637354565},{-43.499377431803964,-108.74942637354565},{-43.499377431803964,-88.74942637354565},{-43.499377431803964,-68.74942637354565},{-43.499377431803964,-48.749426373545646},{-43.499377431803964,-28.749426373545646},{-23.499377431803964,-28.749426373545646},{-3.499377431803964,-28.749426373545646},{16.500622568196036,-28.749426373545646}},color={0,0,127}));
  connect(THeaWatSet_b17d05bd.y,heaInd_3629ff40.TSetBuiSup)
    annotation (Line(points={{-15.79573232489551,-161.75508555435005},{4.204267675104489,-161.75508555435005},{4.204267675104489,-141.75508555435005},{4.204267675104489,-121.75508555435005},{4.204267675104489,-101.75508555435005},{4.204267675104489,-81.75508555435005},{4.204267675104489,-61.755085554350046},{4.204267675104489,-41.755085554350046},{4.204267675104489,-21.755085554350046},{24.20426767510449,-21.755085554350046}},color={0,0,127}));

  //
  // End Connect Statements for b17d05bd
  //



  //
  // Begin Connect Statements for 4718484a
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_fc011ebe.ports_bCon[3],heaInd_3629ff40.port_a1)
    annotation (Line(points={{-29.318199365025222,118.60202217927585},{-29.318199365025222,98.60202217927585},{-29.318199365025222,78.60202217927585},{-29.318199365025222,58.60202217927585},{-29.318199365025222,38.60202217927585},{-29.318199365025222,18.60202217927585},{-29.318199365025222,-1.3979778207241509},{-29.318199365025222,-21.39797782072415},{-9.318199365025222,-21.39797782072415},{10.681800634974778,-21.39797782072415}},color={0,0,127}));
  connect(disNet_fc011ebe.ports_aCon[3],heaInd_3629ff40.port_b1)
    annotation (Line(points={{-26.80470158366854,122.28715538845915},{-26.80470158366854,102.28715538845915},{-26.80470158366854,82.28715538845915},{-26.80470158366854,62.287155388459155},{-26.80470158366854,42.287155388459155},{-26.80470158366854,22.287155388459155},{-26.80470158366854,2.287155388459155},{-26.80470158366854,-17.712844611540845},{-6.804701583668532,-17.712844611540845},{13.195298416331468,-17.712844611540845}},color={0,0,127}));

  //
  // End Connect Statements for 4718484a
  //




annotation(
  experiment(
    StopTime=86400,
    Interval=3600,
    Tolerance=1e-06),
  Diagram(
    coordinateSystem(
      preserveAspectRatio=false,
      extent={{-90.0,-210.0},{90.0,210.0}})),
  Documentation(
    revisions="<html>
 <li>
 May 10, 2020: Hagar Elarga<br/>
Updated implementation to handle template needed for GeoJSON to Modelica.
</li>
</html>"));
end DistrictEnergySystem;