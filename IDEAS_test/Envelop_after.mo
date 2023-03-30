within Model;
model Envelop
inner IDEAS.BoundaryConditions.SimInfoManager       sim
    annotation (Placement(transformation(extent={{-250,298},{-198,350}})));
replaceable package Medium = IDEAS.Media.Air;

 IDEAS.Buildings.Components.Zone     MRoom0BoQ(V=84.64, nSurf=7,hZone=4.000000200000001,redeclare
      package                                                                                             Medium =Medium,n50=0.6,                           T_start=293.15, redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum(nOccFix=6.0),                           redeclare IDEAS.Buildings.Components.OccupancyType.OfficeWork occTyp, redeclare IDEAS.Buildings.Components.RoomType.Generic rooTyp,                           redeclare IDEAS.Buildings.Components.LightingType.LED ligTyp)
annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
 IDEAS.Buildings.Components.SlabOnGround       MMFloor_Generic_150mmHeavy24_SlabRoom0BoQ(     redeclare Model.Data.Constructions.MFloor_Generic_150mmHeavy24 constructionType,    A=23.040000000000045,    inc=3.14,    azi=0,T_start=293.15)
annotation (Placement(transformation(extent={{-137.43325326224107,-144.5025528263194},{-127.43325326224107,-124.5025528263194}})));
 IDEAS.Buildings.Components.OuterWall[4]       MMBasic_Wall_Generic__200mmHeavy24_WallRoom0BoQ(   redeclare Model.Data.Constructions.MBasic_Wall_Generic__200mmHeavy24 constructionType,    A={19.199999999999996, 19.199999999999996, 19.199999999999996, 9.680000000000039},    inc={1.5707963267948966, 1.5707963267948966, 1.5707963267948966, 1.5707963267948966},    azi={1.5707963267948966, 3.141592653589793, 4.709203673205104, 0.0},T_start=293.15)
annotation (Placement(transformation(extent={{-56.71599449570515,-104.89324123940827},{-46.71599449570515,-84.89324123940827}})));
 IDEAS.Buildings.Components.OuterWall       MGenericConstruction_WallRoom0BoQ(   redeclare Model.Data.Constructions.GenericConstruction constructionType,    A=23.040000000000045,    inc=0,    azi=-1,T_start=293.15)
annotation (Placement(transformation(extent={{-139.85906145342295,-184.2732674427695},{-129.85906145342295,-164.2732674427695}})));
 IDEAS.Buildings.Components.Window        MMM_Fixed_3000_x_2000mm_3__WinRoom0BoQ(  A=9.52,    inc=1.5707963267948966,    azi=0.0,    frac=1-0.9,    redeclare IDEAS.Buildings.Components.Shading.None shaType,redeclare Model.Data.Glazing.MM_Fixed_3000_x_2000mm_3_ glazing,    redeclare IDEAS.Buildings.Data.Frames.AluminiumInsulated fraType)
annotation (Placement(transformation(extent={{-98.5684338636774,-136.95729366718928},{-88.5684338636774,-116.95729366718928}})));
equation
connect(MRoom0BoQ.propsBus[1], MMFloor_Generic_150mmHeavy24_SlabRoom0BoQ.propsBus_a)
annotation (Line(points={{-80,-93.0},{-103.71662663112053,-93.0},{-103.71662663112053,-129.5025528263194},{-127.43325326224107,-129.5025528263194}},color={127,0,0},thickness=0.2,pattern=LinePattern.Dash,smooth=Smooth.Bezier));
connect(MRoom0BoQ.propsBus[2:5], MMBasic_Wall_Generic__200mmHeavy24_WallRoom0BoQ.propsBus_a)
annotation (Line(points={{-80,-93.0},{-63.35799724785257,-93.0},{-63.35799724785257,-89.89324123940827},{-46.71599449570515,-89.89324123940827}},color={127,0,0},thickness=0.2,pattern=LinePattern.Dash,smooth=Smooth.Bezier));
connect(MRoom0BoQ.propsBus[6], MGenericConstruction_WallRoom0BoQ.propsBus_a)
annotation (Line(points={{-80,-93.0},{-104.92953072671148,-93.0},{-104.92953072671148,-169.2732674427695},{-129.85906145342295,-169.2732674427695}},color={127,0,0},thickness=0.2,pattern=LinePattern.Dash,smooth=Smooth.Bezier));
connect(MRoom0BoQ.propsBus[7], MMM_Fixed_3000_x_2000mm_3__WinRoom0BoQ.propsBus_a)
annotation (Line(points={{-80,-93.0},{-84.2842169318387,-93.0},{-84.2842169318387,-121.95729366718928},{-88.5684338636774,-121.95729366718928}},color={127,0,0},thickness=0.2,pattern=LinePattern.Dash,smooth=Smooth.Bezier));
end Envelop;
