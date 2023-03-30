within doe_small_demo.Districts;
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
  // Begin Model Instance for disNet_bda61a7f
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_bda61a7f=3;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_bda61a7f=sum({
    cooInd_cccc4465.mDis_flow_nominal,
  cooInd_dea1a99f.mDis_flow_nominal,
  cooInd_93a6a16c.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_bda61a7f[nBui_disNet_bda61a7f]={
    cooInd_cccc4465.mDis_flow_nominal,
  cooInd_dea1a99f.mDis_flow_nominal,
  cooInd_93a6a16c.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_bda61a7f[nBui_disNet_bda61a7f](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_bda61a7f*0.1},
    fill(
      dp_nominal_disNet_bda61a7f*0.9/(nBui_disNet_bda61a7f-1),
      nBui_disNet_bda61a7f-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_bda61a7f=dpSetPoi_disNet_bda61a7f+nBui_disNet_bda61a7f*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_bda61a7f=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_bda61a7f(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_bda61a7f,
    iConDpSen=nBui_disNet_bda61a7f,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_bda61a7f,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_bda61a7f,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_bda61a7f)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,180.0},{-10.0,190.0}})));
  //
  // End Model Instance for disNet_bda61a7f
  //


  
  //
  // Begin Model Instance for cooPla_bae9df1b
  // Source template: /model_connectors/plants/templates/CoolingPlant_Instance.mopt
  //
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal_cooPla_bae9df1b=cooPla_bae9df1b.numChi*(cooPla_bae9df1b.perChi.mEva_flow_nominal)
    "Nominal chilled water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal_cooPla_bae9df1b=cooPla_bae9df1b.perChi.mCon_flow_nominal
    "Nominal condenser water mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dpCHW_nominal_cooPla_bae9df1b=44.8*1000
    "Nominal chilled water side pressure";
  parameter Modelica.Units.SI.PressureDifference dpCW_nominal_cooPla_bae9df1b=46.2*1000
    "Nominal condenser water side pressure";
  parameter Modelica.Units.SI.Power QEva_nominal_cooPla_bae9df1b=mCHW_flow_nominal_cooPla_bae9df1b*4200*(5-14)
    "Nominal cooling capaciaty (Negative means cooling)";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_cooPla_bae9df1b=0.2*mCHW_flow_nominal_cooPla_bae9df1b/cooPla_bae9df1b.numChi
    "Minimum mass flow rate of single chiller";
  // control settings
  parameter Modelica.Units.SI.Pressure dpSetPoi_cooPla_bae9df1b=70000
    "Differential pressure setpoint";
  parameter Modelica.Units.SI.Pressure pumDP_cooPla_bae9df1b=dpCHW_nominal_cooPla_bae9df1b+dpSetPoi_cooPla_bae9df1b+200000;
  parameter Modelica.Units.SI.Time tWai_cooPla_bae9df1b=30
    "Waiting time";
  // pumps
  parameter Buildings.Fluid.Movers.Data.Generic perCHWPum_cooPla_bae9df1b(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=((mCHW_flow_nominal_cooPla_bae9df1b/cooPla_bae9df1b.numChi)/1000)*{0.1,1,1.2},
      dp=pumDP_cooPla_bae9df1b*{1.2,1,0.1}))
    "Performance data for chilled water pumps";
  parameter Buildings.Fluid.Movers.Data.Generic perCWPum_cooPla_bae9df1b(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mCW_flow_nominal_cooPla_bae9df1b/1000*{0.2,0.6,1.0,1.2},
      dp=(dpCW_nominal_cooPla_bae9df1b+60000+6000)*{1.2,1.1,1.0,0.6}))
    "Performance data for condenser water pumps";


  Modelica.Blocks.Sources.RealExpression TSetChiWatDis_cooPla_bae9df1b(
    y=5+273.15)
    "Chilled water supply temperature set point on district level."
    annotation (Placement(transformation(extent={{10.0,-190.0},{30.0,-170.0}})));
  Modelica.Blocks.Sources.BooleanConstant on_cooPla_bae9df1b
    "On signal of the plant"
    annotation (Placement(transformation(extent={{50.0,-190.0},{70.0,-170.0}})));

  doe_small_demo.Plants.CentralCoolingPlant cooPla_bae9df1b(
    redeclare Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19EX_5208kW_6_88COP_Vanes perChi,
    perCHWPum=perCHWPum_cooPla_bae9df1b,
    perCWPum=perCWPum_cooPla_bae9df1b,
    mCHW_flow_nominal=mCHW_flow_nominal_cooPla_bae9df1b,
    dpCHW_nominal=dpCHW_nominal_cooPla_bae9df1b,
    QEva_nominal=QEva_nominal_cooPla_bae9df1b,
    mMin_flow=mMin_flow_cooPla_bae9df1b,
    mCW_flow_nominal=mCW_flow_nominal_cooPla_bae9df1b,
    dpCW_nominal=dpCW_nominal_cooPla_bae9df1b,
    TAirInWB_nominal=298.7,
    TCW_nominal=308.15,
    TMin=288.15,
    tWai=tWai_cooPla_bae9df1b,
    dpSetPoi=dpSetPoi_cooPla_bae9df1b
    )
    "District cooling plant."
    annotation (Placement(transformation(extent={{-70.0,170.0},{-50.0,190.0}})));
  //
  // End Model Instance for cooPla_bae9df1b
  //


  
  //
  // Begin Model Instance for disNet_5ff5935a
  // Source template: /model_connectors/networks/templates/Network2Pipe_Instance.mopt
  //
parameter Integer nBui_disNet_5ff5935a=3;
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_disNet_5ff5935a=sum({
    heaInd_dade6ee1.mDis_flow_nominal,
  heaInd_d2852b96.mDis_flow_nominal,
  heaInd_37a456e0.mDis_flow_nominal})
    "Nominal mass flow rate of the distribution pump";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal_disNet_5ff5935a[nBui_disNet_5ff5935a]={
    heaInd_dade6ee1.mDis_flow_nominal,
  heaInd_d2852b96.mDis_flow_nominal,
  heaInd_37a456e0.mDis_flow_nominal}
    "Nominal mass flow rate in each connection line";
  parameter Modelica.Units.SI.PressureDifference dpDis_nominal_disNet_5ff5935a[nBui_disNet_5ff5935a](
    each min=0,
    each displayUnit="Pa")=1/2 .* cat(
    1,
    {dp_nominal_disNet_5ff5935a*0.1},
    fill(
      dp_nominal_disNet_5ff5935a*0.9/(nBui_disNet_5ff5935a-1),
      nBui_disNet_5ff5935a-1))
    "Pressure drop between each connected building at nominal conditions (supply line)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_disNet_5ff5935a=dpSetPoi_disNet_5ff5935a+nBui_disNet_5ff5935a*7000
    "District network pressure drop";
  // NOTE: this differential pressure setpoint is currently utilized by plants elsewhere
  parameter Modelica.Units.SI.Pressure dpSetPoi_disNet_5ff5935a=50000
    "Differential pressure setpoint";

  Buildings.Experimental.DHC.Networks.Distribution2Pipe disNet_5ff5935a(
    redeclare final package Medium=MediumW,
    final nCon=nBui_disNet_5ff5935a,
    iConDpSen=nBui_disNet_5ff5935a,
    final mDis_flow_nominal=mDis_flow_nominal_disNet_5ff5935a,
    final mCon_flow_nominal=mCon_flow_nominal_disNet_5ff5935a,
    final allowFlowReversal=false,
    dpDis_nominal=dpDis_nominal_disNet_5ff5935a)
    "Distribution network."
    annotation (Placement(transformation(extent={{-30.0,140.0},{-10.0,150.0}})));
  //
  // End Model Instance for disNet_5ff5935a
  //


  
  //
  // Begin Model Instance for heaPla4dd00865
  // Source template: /model_connectors/plants/templates/HeatingPlant_Instance.mopt
  //
  // heating plant instance
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal_heaPla4dd00865=mBoi_flow_nominal_heaPla4dd00865*heaPla4dd00865.numBoi
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal_heaPla4dd00865=QBoi_nominal_heaPla4dd00865/(4200*heaPla4dd00865.delT_nominal)
    "Nominal heating water mass flow rate";
  parameter Modelica.Units.SI.Power QBoi_nominal_heaPla4dd00865=Q_flow_nominal_heaPla4dd00865/heaPla4dd00865.numBoi
    "Nominal heating capaciaty";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_heaPla4dd00865=1000000*2
    "Heating load";
  parameter Modelica.Units.SI.MassFlowRate mMin_flow_heaPla4dd00865=0.2*mBoi_flow_nominal_heaPla4dd00865
    "Minimum mass flow rate of single boiler";
  // controls
  parameter Modelica.Units.SI.Pressure pumDP=(heaPla4dd00865.dpBoi_nominal+dpSetPoi_disNet_5ff5935a+50000)
    "Heating water pump pressure drop";
  parameter Modelica.Units.SI.Time tWai_heaPla4dd00865=30
    "Waiting time";
  parameter Buildings.Fluid.Movers.Data.Generic perHWPum_heaPla4dd00865(
    pressure=Buildings.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
      V_flow=mBoi_flow_nominal_heaPla4dd00865/1000*{0.1,1.1},
      dp=pumDP*{1.1,0.1}))
    "Performance data for heating water pumps";

  doe_small_demo.Plants.CentralHeatingPlant heaPla4dd00865(
    perHWPum=perHWPum_heaPla4dd00865,
    mHW_flow_nominal=mHW_flow_nominal_heaPla4dd00865,
    QBoi_flow_nominal=QBoi_nominal_heaPla4dd00865,
    mMin_flow=mMin_flow_heaPla4dd00865,
    mBoi_flow_nominal=mBoi_flow_nominal_heaPla4dd00865,
    dpBoi_nominal=10000,
    delT_nominal(
      displayUnit="degC")=15,
    tWai=tWai_heaPla4dd00865,
    // TODO: we're currently grabbing dpSetPoi from the Network instance -- need feedback to determine if that's the proper "home" for it
    dpSetPoi=dpSetPoi_disNet_5ff5935a
    )
    "District heating plant."
    annotation (Placement(transformation(extent={{-70.0,130.0},{-50.0,150.0}})));
  //
  // End Model Instance for heaPla4dd00865
  //


  
  //
  // Begin Model Instance for TimeSerLoa_66042f1d
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  doe_small_demo.Loads.B2.TimeSeriesBuilding TimeSerLoa_66042f1d(
    
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
  // End Model Instance for TimeSerLoa_66042f1d
  //


  
  //
  // Begin Model Instance for cooInd_cccc4465
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  doe_small_demo.Substations.CoolingIndirect_2 cooInd_cccc4465(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_b9a417b1,
    mBui_flow_nominal=mBui_flow_nominal_b9a417b1,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_b9a417b1,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,170.0},{30.0,190.0}})));
  //
  // End Model Instance for cooInd_cccc4465
  //


  
  //
  // Begin Model Instance for heaInd_dade6ee1
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  doe_small_demo.Substations.HeatingIndirect_2 heaInd_dade6ee1(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_9dcdad90,
    mBui_flow_nominal=mBui_flow_nominal_9dcdad90,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_9dcdad90,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,130.0},{30.0,150.0}})));
  //
  // End Model Instance for heaInd_dade6ee1
  //


  
  //
  // Begin Model Instance for TimeSerLoa_aa553b6a
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  doe_small_demo.Loads.B6.TimeSeriesBuilding TimeSerLoa_aa553b6a(
    
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
  // End Model Instance for TimeSerLoa_aa553b6a
  //


  
  //
  // Begin Model Instance for cooInd_dea1a99f
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  doe_small_demo.Substations.CoolingIndirect_6 cooInd_dea1a99f(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_885d935f,
    mBui_flow_nominal=mBui_flow_nominal_885d935f,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_885d935f,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,50.0},{30.0,70.0}})));
  //
  // End Model Instance for cooInd_dea1a99f
  //


  
  //
  // Begin Model Instance for heaInd_d2852b96
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  doe_small_demo.Substations.HeatingIndirect_6 heaInd_d2852b96(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_eb954742,
    mBui_flow_nominal=mBui_flow_nominal_eb954742,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_eb954742,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,90.0},{30.0,110.0}})));
  //
  // End Model Instance for heaInd_d2852b96
  //


  
  //
  // Begin Model Instance for TimeSerLoa_cdb15a0c
  // Source template: /model_connectors/load_connectors/templates/TimeSeries_Instance.mopt
  //
  // time series load
  doe_small_demo.Loads.B11.TimeSeriesBuilding TimeSerLoa_cdb15a0c(
    
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
  // End Model Instance for TimeSerLoa_cdb15a0c
  //


  
  //
  // Begin Model Instance for cooInd_93a6a16c
  // Source template: /model_connectors/energy_transfer_systems/templates/CoolingIndirect_Instance.mopt
  //
  // cooling indirect instance
  doe_small_demo.Substations.CoolingIndirect_11 cooInd_93a6a16c(
    redeclare package Medium=MediumW,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    mDis_flow_nominal=mDis_flow_nominal_dcfe196a,
    mBui_flow_nominal=mBui_flow_nominal_dcfe196a,
    dp1_nominal=500,
    dp2_nominal=500,
    dpValve_nominal=7000,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_dcfe196a,
    // TODO: dehardcode the nominal temperatures?
    T_a1_nominal=273.15+5,
    T_a2_nominal=273.15+13)
    "Indirect cooling energy transfer station ETS."
    annotation (Placement(transformation(extent={{10.0,-30.0},{30.0,-10.0}})));
  //
  // End Model Instance for cooInd_93a6a16c
  //


  
  //
  // Begin Model Instance for heaInd_37a456e0
  // Source template: /model_connectors/energy_transfer_systems/templates/HeatingIndirect_Instance.mopt
  //
  // heating indirect instance
  doe_small_demo.Substations.HeatingIndirect_11 heaInd_37a456e0(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium=MediumW,
    mDis_flow_nominal=mDis_flow_nominal_7051e711,
    mBui_flow_nominal=mBui_flow_nominal_7051e711,
    dpValve_nominal=6000,
    dp1_nominal=500,
    dp2_nominal=500,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nominal_7051e711,
    T_a1_nominal=55+273.15,
    T_a2_nominal=35+273.15,
    k=0.1,
    Ti=60,
    reverseActing=true)
    annotation (Placement(transformation(extent={{10.0,10.0},{30.0,30.0}})));
  //
  // End Model Instance for heaInd_37a456e0
  //


  

  // Model dependencies

  //
  // Begin Component Definitions for 845da3a7
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ComponentDefinitions.mopt
  //
  // No components for pipe and cooling plant

  //
  // End Component Definitions for 845da3a7
  //



  //
  // Begin Component Definitions for 49a9e094
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ComponentDefinitions.mopt
  //
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.BooleanConstant mPum_flow_49a9e094(
    k=true)
    "Total heating water pump mass flow rate"
    annotation (Placement(transformation(extent={{-70.0,-70.0},{-50.0,-50.0}})));
  // TODO: This should not be here, it is entirely plant specific and should be moved elsewhere
  // but since it requires a connect statement we must put it here for now...
  Modelica.Blocks.Sources.RealExpression TDisSetHeaWat_49a9e094(
    each y=273.15+54)
    "District side heating water supply temperature set point."
    annotation (Placement(transformation(extent={{-30.0,-70.0},{-10.0,-50.0}})));

  //
  // End Component Definitions for 49a9e094
  //



  //
  // Begin Component Definitions for b9a417b1
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_b9a417b1=TimeSerLoa_66042f1d.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_b9a417b1=TimeSerLoa_66042f1d.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_b9a417b1=-1*(TimeSerLoa_66042f1d.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_b9a417b1(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-70.0},{30.0,-50.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_b9a417b1(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-70.0},{70.0,-50.0}})));

  //
  // End Component Definitions for b9a417b1
  //



  //
  // Begin Component Definitions for 7126ca19
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 7126ca19
  //



  //
  // Begin Component Definitions for 9dcdad90
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_9dcdad90=TimeSerLoa_66042f1d.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_9dcdad90=TimeSerLoa_66042f1d.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_9dcdad90=(TimeSerLoa_66042f1d.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_9dcdad90(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-110.0},{-50.0,-90.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_9dcdad90(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-110.0},{-10.0,-90.0}})));

  //
  // End Component Definitions for 9dcdad90
  //



  //
  // Begin Component Definitions for c4557597
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for c4557597
  //



  //
  // Begin Component Definitions for 885d935f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_885d935f=TimeSerLoa_aa553b6a.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_885d935f=TimeSerLoa_aa553b6a.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_885d935f=-1*(TimeSerLoa_aa553b6a.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_885d935f(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-110.0},{30.0,-90.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_885d935f(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-110.0},{70.0,-90.0}})));

  //
  // End Component Definitions for 885d935f
  //



  //
  // Begin Component Definitions for 51210b16
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for 51210b16
  //



  //
  // Begin Component Definitions for eb954742
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_eb954742=TimeSerLoa_aa553b6a.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_eb954742=TimeSerLoa_aa553b6a.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_eb954742=(TimeSerLoa_aa553b6a.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_eb954742(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-150.0},{-50.0,-130.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_eb954742(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-150.0},{-10.0,-130.0}})));

  //
  // End Component Definitions for eb954742
  //



  //
  // Begin Component Definitions for 350c54f1
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for 350c54f1
  //



  //
  // Begin Component Definitions for dcfe196a
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + CoolingIndirect Component Definitions
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_dcfe196a=TimeSerLoa_cdb15a0c.mChiWat_flow_nominal*delChiWatTemBui/delChiWatTemDis
    "Nominal mass flow rate of primary (district) district cooling side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_dcfe196a=TimeSerLoa_cdb15a0c.mChiWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district cooling side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_dcfe196a=-1*(TimeSerLoa_cdb15a0c.QCoo_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_dcfe196a(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{10.0,-150.0},{30.0,-130.0}})));
  // TODO: move TChiWatSet (and its connection) into a CoolingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression TChiWatSet_dcfe196a(
    y=7+273.15)
    //Dehardcode
    "Primary loop (district side) chilled water setpoint temperature."
    annotation (Placement(transformation(extent={{50.0,-150.0},{70.0,-130.0}})));

  //
  // End Component Definitions for dcfe196a
  //



  //
  // Begin Component Definitions for eda45b26
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for cooling indirect and network 2 pipe

  //
  // End Component Definitions for eda45b26
  //



  //
  // Begin Component Definitions for 7051e711
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ComponentDefinitions.mopt
  //
  // TimeSeries + HeatingIndirect Component Definitions
  // TODO: the components below need to be fixed!
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal_7051e711=TimeSerLoa_cdb15a0c.mHeaWat_flow_nominal*delHeaWatTemBui/delHeaWatTemDis
    "Nominal mass flow rate of primary (district) district heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal_7051e711=TimeSerLoa_cdb15a0c.mHeaWat_flow_nominal
    "Nominal mass flow rate of secondary (building) district heating side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal_7051e711=(TimeSerLoa_cdb15a0c.QHea_flow_nominal);
  Modelica.Fluid.Sources.FixedBoundary pressure_source_7051e711(
    redeclare package Medium=MediumW,
    use_T=false,
    nPorts=1)
    "Pressure source"
    annotation (Placement(transformation(extent={{-70.0,-190.0},{-50.0,-170.0}})));
  // TODO: move THeaWatSet (and its connection) into a HeatingIndirect specific template file (this component does not depend on the coupling)
  Modelica.Blocks.Sources.RealExpression THeaWatSet_7051e711(
    // y=40+273.15)
    y=273.15+40 )
    "Secondary loop (Building side) heating water setpoint temperature."
    //Dehardcode
    annotation (Placement(transformation(extent={{-30.0,-190.0},{-10.0,-170.0}})));

  //
  // End Component Definitions for 7051e711
  //



  //
  // Begin Component Definitions for dd03860d
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ComponentDefinitions.mopt
  //
  // no component definitions for heating indirect and network 2 pipe

  //
  // End Component Definitions for dd03860d
  //



equation
  // Connections

  //
  // Begin Connect Statements for 845da3a7
  // Source template: /model_connectors/couplings/templates/Network2Pipe_CoolingPlant/ConnectStatements.mopt
  //

  // TODO: these connect statements shouldn't be here, they are plant specific
  // but since we can't currently make connect statements for single systems, this is what we've got
  connect(on_cooPla_bae9df1b.y,cooPla_bae9df1b.on)
    annotation (Line(points={{52.87190494359447,-151.49593443584746},{32.87190494359447,-151.49593443584746},{32.87190494359447,-131.49593443584746},{32.87190494359447,-111.49593443584746},{32.87190494359447,-91.49593443584746},{32.87190494359447,-71.49593443584746},{32.87190494359447,-51.49593443584746},{32.87190494359447,-31.49593443584746},{32.87190494359447,-11.49593443584746},{32.87190494359447,8.50406556415254},{32.87190494359447,28.50406556415254},{32.87190494359447,48.50406556415254},{32.87190494359447,68.50406556415254},{32.87190494359447,88.50406556415254},{32.87190494359447,108.50406556415254},{32.87190494359447,128.50406556415254},{32.87190494359447,148.50406556415254},{32.87190494359447,168.50406556415254},{12.871904943594473,168.50406556415254},{-7.128095056405527,168.50406556415254},{-27.128095056405535,168.50406556415254},{-47.128095056405535,168.50406556415254},{-47.128095056405535,188.50406556415254},{-67.12809505640553,188.50406556415254}},color={0,0,127}));
  connect(TSetChiWatDis_cooPla_bae9df1b.y,cooPla_bae9df1b.TCHWSupSet)
    annotation (Line(points={{19.82162618464011,-151.68365348543017},{-0.1783738153598904,-151.68365348543017},{-0.1783738153598904,-131.68365348543017},{-0.1783738153598904,-111.68365348543017},{-0.1783738153598904,-91.68365348543017},{-0.1783738153598904,-71.68365348543017},{-0.1783738153598904,-51.68365348543017},{-0.1783738153598904,-31.6836534854302},{-0.1783738153598904,-11.683653485430199},{-0.1783738153598904,8.316346514569801},{-0.1783738153598904,28.3163465145698},{-0.1783738153598904,48.3163465145698},{-0.1783738153598904,68.3163465145698},{-0.1783738153598904,88.3163465145698},{-0.1783738153598904,108.3163465145698},{-0.1783738153598904,128.3163465145698},{-0.1783738153598904,148.3163465145698},{-0.1783738153598904,168.3163465145698},{-20.17837381535989,168.3163465145698},{-40.17837381535989,168.3163465145698},{-40.17837381535989,188.3163465145698},{-60.17837381535989,188.3163465145698}},color={0,0,127}));

  connect(disNet_bda61a7f.port_bDisRet,cooPla_bae9df1b.port_a)
    annotation (Line(points={{-34.885380801011294,189.16176692229672},{-54.885380801011294,189.16176692229672}},color={0,0,127}));
  connect(cooPla_bae9df1b.port_b,disNet_bda61a7f.port_aDisSup)
    annotation (Line(points={{-42.62456501132504,176.75953709708529},{-22.624565011325032,176.75953709708529}},color={0,0,127}));
  connect(disNet_bda61a7f.dp,cooPla_bae9df1b.dpMea)
    annotation (Line(points={{-37.53459225983761,173.61031979638577},{-57.53459225983761,173.61031979638577}},color={0,0,127}));

  //
  // End Connect Statements for 845da3a7
  //



  //
  // Begin Connect Statements for 49a9e094
  // Source template: /model_connectors/couplings/templates/Network2Pipe_HeatingPlant/ConnectStatements.mopt
  //

  connect(heaPla4dd00865.port_a,disNet_5ff5935a.port_bDisRet)
    annotation (Line(points={{-32.521887592313306,147.08209771145482},{-12.521887592313306,147.08209771145482}},color={0,0,127}));
  connect(disNet_5ff5935a.dp,heaPla4dd00865.dpMea)
    annotation (Line(points={{-37.385679638267234,144.51063973858732},{-57.385679638267234,144.51063973858732}},color={0,0,127}));
  connect(heaPla4dd00865.port_b,disNet_5ff5935a.port_aDisSup)
    annotation (Line(points={{-41.03180292762758,145.29203366690206},{-21.03180292762758,145.29203366690206}},color={0,0,127}));
  connect(mPum_flow_49a9e094.y,heaPla4dd00865.on)
    annotation (Line(points={{-69.75660355193662,-34.0488694768016},{-69.75660355193662,-14.048869476801599},{-69.75660355193662,5.951130523198401},{-69.75660355193662,25.9511305231984},{-69.75660355193662,45.9511305231984},{-69.75660355193662,65.9511305231984},{-69.75660355193662,85.9511305231984},{-69.75660355193662,105.9511305231984},{-69.75660355193662,125.9511305231984},{-69.75660355193662,145.9511305231984}},color={0,0,127}));
  connect(TDisSetHeaWat_49a9e094.y,heaPla4dd00865.THeaSet)
    annotation (Line(points={{-11.391190373717805,-32.49341765409673},{-11.391190373717805,-12.493417654096731},{-11.391190373717805,7.506582345903269},{-11.391190373717805,27.50658234590327},{-11.391190373717805,47.50658234590327},{-11.391190373717805,67.50658234590327},{-11.391190373717805,87.50658234590328},{-11.391190373717805,107.50658234590328},{-11.391190373717805,127.50658234590328},{-31.391190373717805,127.50658234590328},{-31.391190373717805,147.50658234590327},{-51.391190373717805,147.50658234590327}},color={0,0,127}));

  //
  // End Connect Statements for 49a9e094
  //



  //
  // Begin Connect Statements for b9a417b1
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_66042f1d.ports_bChiWat[1], cooInd_cccc4465.port_a2)
    annotation (Line(points={{37.93948953496074,188.27428693812703},{17.939489534960742,188.27428693812703}},color={0,0,127}));
  connect(cooInd_cccc4465.port_b2,TimeSerLoa_66042f1d.ports_aChiWat[1])
    annotation (Line(points={{48.29836062506948,187.5315647847653},{68.29836062506948,187.5315647847653}},color={0,0,127}));
  connect(pressure_source_b9a417b1.ports[1], cooInd_cccc4465.port_b2)
    annotation (Line(points={{21.16556243149479,-49.69688154198042},{1.1655624314947914,-49.69688154198042},{1.1655624314947914,-29.69688154198039},{1.1655624314947914,-9.696881541980389},{1.1655624314947914,10.303118458019611},{1.1655624314947914,30.30311845801961},{1.1655624314947914,50.30311845801961},{1.1655624314947914,70.30311845801961},{1.1655624314947914,90.30311845801961},{1.1655624314947914,110.30311845801961},{1.1655624314947914,130.3031184580196},{1.1655624314947914,150.3031184580196},{1.1655624314947914,170.3031184580196},{21.16556243149479,170.3031184580196}},color={0,0,127}));
  connect(TChiWatSet_b9a417b1.y,cooInd_cccc4465.TSetBuiSup)
    annotation (Line(points={{68.44217371220066,-34.24107455565553},{68.44217371220066,-14.24107455565553},{68.44217371220066,5.75892544434447},{48.442173712200656,5.75892544434447},{48.442173712200656,25.75892544434447},{48.442173712200656,45.75892544434447},{48.442173712200656,65.75892544434447},{48.442173712200656,85.75892544434448},{48.442173712200656,105.75892544434448},{48.442173712200656,125.75892544434448},{48.442173712200656,145.75892544434447},{48.442173712200656,165.75892544434447},{48.442173712200656,185.75892544434447},{68.44217371220066,185.75892544434447}},color={0,0,127}));

  //
  // End Connect Statements for b9a417b1
  //



  //
  // Begin Connect Statements for 7126ca19
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_bda61a7f.ports_bCon[1],cooInd_cccc4465.port_a1)
    annotation (Line(points={{-3.5108271052208124,181.5061391791209},{16.489172894779188,181.5061391791209}},color={0,0,127}));
  connect(disNet_bda61a7f.ports_aCon[1],cooInd_cccc4465.port_b1)
    annotation (Line(points={{5.0748314749106385,173.73588997688793},{25.07483147491064,173.73588997688793}},color={0,0,127}));

  //
  // End Connect Statements for 7126ca19
  //



  //
  // Begin Connect Statements for 9dcdad90
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_66042f1d.ports_bHeaWat[1], heaInd_dade6ee1.port_a2)
    annotation (Line(points={{55.84432426398001,167.0899611491972},{55.84432426398001,147.0899611491972},{35.84432426398001,147.0899611491972},{15.844324263980013,147.0899611491972}},color={0,0,127}));
  connect(heaInd_dade6ee1.port_b2,TimeSerLoa_66042f1d.ports_aHeaWat[1])
    annotation (Line(points={{11.287092923781543,156.1774999677833},{31.287092923781543,156.1774999677833},{31.287092923781543,176.1774999677833},{51.28709292378156,176.1774999677833}},color={0,0,127}));
  connect(pressure_source_9dcdad90.ports[1], heaInd_dade6ee1.port_b2)
    annotation (Line(points={{-51.03141576954072,-81.64191919004406},{-31.031415769540722,-81.64191919004406},{-31.031415769540722,-61.641919190044064},{-31.031415769540722,-41.641919190044035},{-31.031415769540722,-21.641919190044035},{-31.031415769540722,-1.6419191900440353},{-31.031415769540722,18.358080809955965},{-31.031415769540722,38.358080809955965},{-31.031415769540722,58.358080809955965},{-31.031415769540722,78.35808080995596},{-31.031415769540722,98.35808080995596},{-31.031415769540722,118.35808080995596},{-11.031415769540729,118.35808080995596},{8.968584230459271,118.35808080995596},{8.968584230459271,138.35808080995596},{28.96858423045927,138.35808080995596}},color={0,0,127}));
  connect(THeaWatSet_9dcdad90.y,heaInd_dade6ee1.TSetBuiSup)
    annotation (Line(points={{-12.21028429297408,-73.10199066310923},{7.78971570702592,-73.10199066310923},{7.78971570702592,-53.101990663109234},{7.78971570702592,-33.101990663109206},{7.78971570702592,-13.101990663109206},{7.78971570702592,6.898009336890794},{7.78971570702592,26.898009336890794},{7.78971570702592,46.898009336890794},{7.78971570702592,66.8980093368908},{7.78971570702592,86.89800933689078},{7.78971570702592,106.89800933689078},{7.78971570702592,126.89800933689078},{7.78971570702592,146.89800933689077},{27.78971570702592,146.89800933689077}},color={0,0,127}));

  //
  // End Connect Statements for 9dcdad90
  //



  //
  // Begin Connect Statements for c4557597
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_5ff5935a.ports_bCon[1],heaInd_dade6ee1.port_a1)
    annotation (Line(points={{3.595160348084562,135.6484757877499},{23.595160348084562,135.6484757877499}},color={0,0,127}));
  connect(disNet_5ff5935a.ports_aCon[1],heaInd_dade6ee1.port_b1)
    annotation (Line(points={{0.14769417398383666,149.92269568316462},{20.147694173983837,149.92269568316462}},color={0,0,127}));

  //
  // End Connect Statements for c4557597
  //



  //
  // Begin Connect Statements for 885d935f
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_aa553b6a.ports_bChiWat[1], cooInd_dea1a99f.port_a2)
    annotation (Line(points={{58.07556628953938,87.1214771054852},{58.07556628953938,67.12147710548521},{38.07556628953938,67.12147710548521},{18.07556628953938,67.12147710548521}},color={0,0,127}));
  connect(cooInd_dea1a99f.port_b2,TimeSerLoa_aa553b6a.ports_aChiWat[1])
    annotation (Line(points={{13.112772413567441,74.24130622514866},{33.11277241356744,74.24130622514866},{33.11277241356744,94.24130622514865},{53.11277241356743,94.24130622514865}},color={0,0,127}));
  connect(pressure_source_885d935f.ports[1], cooInd_dea1a99f.port_b2)
    annotation (Line(points={{20.14118514380715,-80.69617553334655},{0.14118514380714942,-80.69617553334655},{0.14118514380714942,-60.69617553334655},{0.14118514380714942,-40.69617553334655},{0.14118514380714942,-20.696175533346548},{0.14118514380714942,-0.6961755333465476},{0.14118514380714942,19.303824466653452},{0.14118514380714942,39.30382446665345},{0.14118514380714942,59.30382446665345},{20.14118514380715,59.30382446665345}},color={0,0,127}));
  connect(TChiWatSet_885d935f.y,cooInd_dea1a99f.TSetBuiSup)
    annotation (Line(points={{53.081184513801134,-82.6085039181167},{33.08118451380112,-82.6085039181167},{33.08118451380112,-62.608503918116696},{33.08118451380112,-42.608503918116725},{33.08118451380112,-22.608503918116725},{33.08118451380112,-2.6085039181167247},{33.08118451380112,17.391496081883275},{33.08118451380112,37.391496081883275},{33.08118451380112,57.391496081883275},{33.08118451380112,77.39149608188328},{33.08118451380112,97.39149608188329},{53.081184513801134,97.39149608188329}},color={0,0,127}));

  //
  // End Connect Statements for 885d935f
  //



  //
  // Begin Connect Statements for 51210b16
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_bda61a7f.ports_bCon[2],cooInd_dea1a99f.port_a1)
    annotation (Line(points={{-25.710460936722953,167.43506465221606},{-5.710460936722953,167.43506465221606},{-5.710460936722953,147.43506465221606},{-5.710460936722953,127.43506465221607},{-5.710460936722953,107.43506465221607},{-5.710460936722953,87.43506465221607},{-5.710460936722953,67.43506465221606},{14.289539063277047,67.43506465221606}},color={0,0,127}));
  connect(disNet_bda61a7f.ports_aCon[2],cooInd_dea1a99f.port_b1)
    annotation (Line(points={{-29.213172852592294,164.91438943669039},{-9.213172852592294,164.91438943669039},{-9.213172852592294,144.91438943669039},{-9.213172852592294,124.91438943669037},{-9.213172852592294,104.91438943669037},{-9.213172852592294,84.91438943669037},{-9.213172852592294,64.91438943669039},{10.786827147407706,64.91438943669039}},color={0,0,127}));

  //
  // End Connect Statements for 51210b16
  //



  //
  // Begin Connect Statements for eb954742
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_aa553b6a.ports_bHeaWat[1], heaInd_d2852b96.port_a2)
    annotation (Line(points={{44.50830014199016,96.73540047402057},{24.508300141990148,96.73540047402057}},color={0,0,127}));
  connect(heaInd_d2852b96.port_b2,TimeSerLoa_aa553b6a.ports_aHeaWat[1])
    annotation (Line(points={{39.439332148043604,108.9427643241669},{59.439332148043604,108.9427643241669}},color={0,0,127}));
  connect(pressure_source_eb954742.ports[1], heaInd_d2852b96.port_b2)
    annotation (Line(points={{-55.714648906760054,-114.72751190872066},{-35.714648906760054,-114.72751190872066},{-35.714648906760054,-94.72751190872066},{-35.714648906760054,-74.72751190872066},{-35.714648906760054,-54.72751190872066},{-35.714648906760054,-34.72751190872066},{-35.714648906760054,-14.727511908720658},{-35.714648906760054,5.272488091279342},{-35.714648906760054,25.272488091279342},{-35.714648906760054,45.27248809127934},{-35.714648906760054,65.27248809127934},{-35.714648906760054,85.27248809127934},{-35.714648906760054,105.27248809127934},{-15.714648906760061,105.27248809127934},{4.285351093239939,105.27248809127934},{24.28535109323994,105.27248809127934}},color={0,0,127}));
  connect(THeaWatSet_eb954742.y,heaInd_d2852b96.TSetBuiSup)
    annotation (Line(points={{-19.020479651651385,-127.29710063135644},{0.9795203483486148,-127.29710063135644},{0.9795203483486148,-107.29710063135644},{0.9795203483486148,-87.29710063135644},{0.9795203483486148,-67.29710063135644},{0.9795203483486148,-47.29710063135644},{0.9795203483486148,-27.297100631356415},{0.9795203483486148,-7.297100631356415},{0.9795203483486148,12.702899368643585},{0.9795203483486148,32.702899368643585},{0.9795203483486148,52.702899368643585},{0.9795203483486148,72.70289936864359},{0.9795203483486148,92.70289936864359},{20.979520348348615,92.70289936864359}},color={0,0,127}));

  //
  // End Connect Statements for eb954742
  //



  //
  // Begin Connect Statements for 350c54f1
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_5ff5935a.ports_bCon[2],heaInd_d2852b96.port_a1)
    annotation (Line(points={{-16.97731417576965,116.28082331712586},{-16.97731417576965,96.28082331712586},{3.0226858242303507,96.28082331712586},{23.02268582423035,96.28082331712586}},color={0,0,127}));
  connect(disNet_5ff5935a.ports_aCon[2],heaInd_d2852b96.port_b1)
    annotation (Line(points={{-26.060189422206278,120.11021639089289},{-26.060189422206278,100.11021639089289},{-6.060189422206278,100.11021639089289},{13.939810577793722,100.11021639089289}},color={0,0,127}));

  //
  // End Connect Statements for 350c54f1
  //



  //
  // Begin Connect Statements for dcfe196a
  // Source template: /model_connectors/couplings/templates/TimeSeries_CoolingIndirect/ConnectStatements.mopt
  //

  // cooling indirect, timeseries coupling connections
  connect(TimeSerLoa_cdb15a0c.ports_bChiWat[1], cooInd_93a6a16c.port_a2)
    annotation (Line(points={{66.16740420526298,8.698913928973525},{66.16740420526298,-11.301086071026475},{46.16740420526298,-11.301086071026475},{26.167404205262983,-11.301086071026475}},color={0,0,127}));
  connect(cooInd_93a6a16c.port_b2,TimeSerLoa_cdb15a0c.ports_aChiWat[1])
    annotation (Line(points={{23.86663547020352,1.831803366801637},{43.86663547020353,1.831803366801637},{43.86663547020353,21.831803366801637},{63.86663547020353,21.831803366801637}},color={0,0,127}));
  connect(pressure_source_dcfe196a.ports[1], cooInd_93a6a16c.port_b2)
    annotation (Line(points={{12.93393249811065,-114.1993592911262},{-7.06606750188935,-114.1993592911262},{-7.06606750188935,-94.1993592911262},{-7.06606750188935,-74.1993592911262},{-7.06606750188935,-54.1993592911262},{-7.06606750188935,-34.1993592911262},{-7.06606750188935,-14.1993592911262},{12.93393249811065,-14.1993592911262}},color={0,0,127}));
  connect(TChiWatSet_dcfe196a.y,cooInd_93a6a16c.TSetBuiSup)
    annotation (Line(points={{58.44434777704285,-116.86877451451761},{38.44434777704285,-116.86877451451761},{38.44434777704285,-96.86877451451761},{38.44434777704285,-76.86877451451761},{38.44434777704285,-56.86877451451761},{38.44434777704285,-36.86877451451764},{38.44434777704285,-16.86877451451764},{38.44434777704285,3.1312254854823607},{38.44434777704285,23.13122548548236},{58.44434777704285,23.13122548548236}},color={0,0,127}));

  //
  // End Connect Statements for dcfe196a
  //



  //
  // Begin Connect Statements for eda45b26
  // Source template: /model_connectors/couplings/templates/CoolingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // cooling indirect and network 2 pipe
  
  connect(disNet_bda61a7f.ports_bCon[3],cooInd_93a6a16c.port_a1)
    annotation (Line(points={{-26.603841815089282,158.8986043447407},{-6.603841815089282,158.8986043447407},{-6.603841815089282,138.8986043447407},{-6.603841815089282,118.8986043447407},{-6.603841815089282,98.8986043447407},{-6.603841815089282,78.8986043447407},{-6.603841815089282,58.898604344740704},{-6.603841815089282,38.898604344740704},{-6.603841815089282,18.898604344740704},{-6.603841815089282,-1.1013956552592958},{-6.603841815089282,-21.101395655259296},{13.396158184910718,-21.101395655259296}},color={0,0,127}));
  connect(disNet_bda61a7f.ports_aCon[3],cooInd_93a6a16c.port_b1)
    annotation (Line(points={{-29.871649197578847,167.18774814120002},{-9.871649197578847,167.18774814120002},{-9.871649197578847,147.18774814120002},{-9.871649197578847,127.1877481412},{-9.871649197578847,107.1877481412},{-9.871649197578847,87.1877481412},{-9.871649197578847,67.18774814120002},{-9.871649197578847,47.18774814120002},{-9.871649197578847,27.187748141200018},{-9.871649197578847,7.187748141200018},{-9.871649197578847,-12.812251858799982},{10.128350802421153,-12.812251858799982}},color={0,0,127}));

  //
  // End Connect Statements for eda45b26
  //



  //
  // Begin Connect Statements for 7051e711
  // Source template: /model_connectors/couplings/templates/TimeSeries_HeatingIndirect/ConnectStatements.mopt
  //

  // heating indirect, timeseries coupling connections
  connect(TimeSerLoa_cdb15a0c.ports_bHeaWat[1], heaInd_37a456e0.port_a2)
    annotation (Line(points={{35.63018017909195,28.526044010666},{15.630180179091951,28.526044010666}},color={0,0,127}));
  connect(heaInd_37a456e0.port_b2,TimeSerLoa_cdb15a0c.ports_aHeaWat[1])
    annotation (Line(points={{39.07538454667986,12.112645065691197},{59.07538454667986,12.112645065691197}},color={0,0,127}));
  connect(pressure_source_7051e711.ports[1], heaInd_37a456e0.port_b2)
    annotation (Line(points={{-50.47357164076952,-169.17660387639478},{-30.47357164076952,-169.17660387639478},{-30.47357164076952,-149.17660387639478},{-30.47357164076952,-129.17660387639478},{-30.47357164076952,-109.17660387639478},{-30.47357164076952,-89.17660387639478},{-30.47357164076952,-69.17660387639478},{-30.47357164076952,-49.17660387639478},{-30.47357164076952,-29.176603876394807},{-30.47357164076952,-9.176603876394807},{-30.47357164076952,10.823396123605193},{-10.47357164076952,10.823396123605193},{9.52642835923048,10.823396123605193},{29.52642835923048,10.823396123605193}},color={0,0,127}));
  connect(THeaWatSet_7051e711.y,heaInd_37a456e0.TSetBuiSup)
    annotation (Line(points={{-13.426464511788623,-156.74786209548643},{6.573535488211377,-156.74786209548643},{6.573535488211377,-136.74786209548643},{6.573535488211377,-116.74786209548643},{6.573535488211377,-96.74786209548643},{6.573535488211377,-76.74786209548643},{6.573535488211377,-56.747862095486425},{6.573535488211377,-36.747862095486425},{6.573535488211377,-16.747862095486425},{6.573535488211377,3.2521379045135745},{6.573535488211377,23.252137904513575},{26.573535488211377,23.252137904513575}},color={0,0,127}));

  //
  // End Connect Statements for 7051e711
  //



  //
  // Begin Connect Statements for dd03860d
  // Source template: /model_connectors/couplings/templates/HeatingIndirect_Network2Pipe/ConnectStatements.mopt
  //

  // heating indirect and network 2 pipe
  
  connect(disNet_5ff5935a.ports_bCon[3],heaInd_37a456e0.port_a1)
    annotation (Line(points={{-27.837909270850425,113.50337396495311},{-27.837909270850425,93.50337396495311},{-27.837909270850425,73.50337396495311},{-27.837909270850425,53.50337396495311},{-27.837909270850425,33.50337396495311},{-27.837909270850425,13.503373964953113},{-7.837909270850417,13.503373964953113},{12.162090729149583,13.503373964953113}},color={0,0,127}));
  connect(disNet_5ff5935a.ports_aCon[3],heaInd_37a456e0.port_b1)
    annotation (Line(points={{-21.151825102002647,119.73087785690672},{-21.151825102002647,99.73087785690672},{-21.151825102002647,79.73087785690672},{-21.151825102002647,59.730877856906716},{-21.151825102002647,39.730877856906716},{-21.151825102002647,19.730877856906716},{-1.1518251020026469,19.730877856906716},{18.848174897997353,19.730877856906716}},color={0,0,127}));

  //
  // End Connect Statements for dd03860d
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