class OLBaseSplineActor extends Actor;

enum EPathPortionType
{
    PPT_Acceleration,
    PPT_Braking,
    PPT_MAX
};

struct native CurvePointStruct
{
    var() Vector Point;
    var() Vector Tangent;

    structdefaultproperties
    {
        Point=(X=0,Y=0,Z=0)
        Tangent=(X=0,Y=0,Z=0)
    }
};

struct native PathPortionStruct
{
    var() float PathPortionStart;
    var() float PathPortionEnd;
    var() MaterialInterface PathPortionMaterial;
    var transient MaterialInstanceConstant PathPortionMaterialInst;
    var() OLBaseSplineActor.EPathPortionType PathPortionType;
    var() float Value;

    structdefaultproperties
    {
        PathPortionStart=0
        PathPortionEnd=0
        PathPortionMaterial=none
        PathPortionMaterialInst=none
        PathPortionType=PPT_Acceleration
        Value=100
    }
};

var const Guid UniqueGUID;
var const Guid TravelTargetGUID;
var(Spline) array<CurvePointStruct> ControlPoints;
var(Spline) array<PathPortionStruct> PathPortions;
var(Spline) float SurfingSpeed;
var(Spline) float SplineTransitAcceleration;