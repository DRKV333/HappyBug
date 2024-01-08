class HappyBugPlayerController extends PlayerController;

DefaultProperties
{
}

exec function HBCinematic(string CinematicName)
{
    local Sequence GameSeq;
    local array<SequenceObject> CinematicObjects;
    local SequenceObject CinematicObject;
    local RUSeqEvent_CinematicActivated Cinematic;

    GameSeq = WorldInfo.GetGameSequence();
    if (GameSeq != none)
    {
        
        GameSeq.FindSeqObjectsByClass(class'RUSeqEvent_CinematicActivated', true, CinematicObjects);
        foreach CinematicObjects(CinematicObject)
        {
            Cinematic = RUSeqEvent_CinematicActivated(CinematicObject);
            if (CinematicName == string(Cinematic.CinematicName))
            {
                ClientMessage("Activated!");
                Cinematic.CheckActivate(Self, Self);
                return;
            }
        }

        ClientMessage("Available cinematics:");
        foreach CinematicObjects(CinematicObject)
        {
            Cinematic = RUSeqEvent_CinematicActivated(CinematicObject);
            ClientMessage(Cinematic.CinematicName);
        }
    }
}

exec function HBUnhideAll()
{
    local Actor AnActor;

    foreach AllActors(class'Actor', AnActor)
    {
        AnActor.SetHidden(false);
    } 
}

exec function HBMatinee(optional int Index = -1, bool ResetOnly = false)
{
    local Sequence GameSeq;
    local array<SequenceObject> InterpObjects;
    local SeqAct_Interp Interp;

    GameSeq = WorldInfo.GetGameSequence();
    if (GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(class'SeqAct_Interp', true, InterpObjects);
        
        if (Index >= 0 && Index < InterpObjects.Length)
        {
            ClientMessage("Activated!");
            Interp = SeqAct_Interp(InterpObjects[Index]);
            Interp.Reset();
            if (!ResetOnly)
                Interp.ForceActivateInput(0);
        }
        else
        {
            ClientMessage("Number of Matinees:"@InterpObjects.Length);
        }
    }
}

exec function HBGhost()
{
    bCollideWorld = !bCollideWorld;
    if (bCollideWorld)
        ClientMessage("World collision enabled.");
    else
        ClientMessage("World collision disabled.");
}

exec function HBSpeed(float NewSpeed = -1)
{
    if (NewSpeed == -1)
    {
        if (SpectatorCameraSpeed < 1000)
            SpectatorCameraSpeed = 5000;
        else
            SpectatorCameraSpeed = 600;
    }
    else
    {
        SpectatorCameraSpeed = NewSpeed;
    }

    ClientMessage("Set camera speed to"@SpectatorCameraSpeed);
}

exec function DumpFlightTubes()
{
    local JsonObject Json;
    local JsonObject TubeJson;
    local JsonObject ControlPointArrayJson;
    local JsonObject ControlPointJson;
    local JsonObject PathPortionArrayJson;
    local JsonObject PathPortionJson;
    local OLFlightTubeActor ATube;
    local OLBaseSplineActor.CurvePointStruct AControlPoint;
    local OLBaseSplineActor.PathPortionStruct APathPortion;

    Json = new class'JsonObject';

    foreach AllActors(class'OLFlightTubeActor', ATube)
    {
        TubeJson = new class'JsonObject';
        Json.ObjectArray.AddItem(TubeJson);

        TubeJson.SetFloatValue("RingDensity", ATube.RingDensity);
        TubeJson.SetFloatValue("SurfingSpeed", ATube.SurfingSpeed);
        TubeJson.SetFloatValue("SplineTransitAcceleration", ATube.SplineTransitAcceleration);

        TubeJson.SetObject("UniqueGUID", Guid2Json(ATube.UniqueGUID));
        TubeJson.SetObject("TravelTargetGUID", Guid2Json(ATube.TravelTargetGUID));
        TubeJson.SetObject("Location", Vec2Json(ATube.Location));

        ControlPointArrayJson = new class'JsonObject';
        TubeJson.SetObject("ControlPoints", ControlPointArrayJson);

        foreach ATube.ControlPoints(AControlPoint)
        {
            ControlPointJson = new class'JsonObject';
            ControlPointArrayJson.ObjectArray.AddItem(ControlPointJson);

            ControlPointJson.SetObject("Point", Vec2Json(AControlPoint.Point));
            ControlPointJson.SetObject("Tangent", Vec2Json(AControlPoint.Tangent));
        }

        PathPortionArrayJson = new class'JsonObject';
        TubeJson.SetObject("PathPortions", PathPortionArrayJson);

        foreach ATube.PathPortions(APathPortion)
        {
            PathPortionJson = new class'JsonObject';
            PathPortionArrayJson.ObjectArray.AddItem(PathPortionJson);

            PathPortionJson.SetFloatValue("PathPortionStart", APathPortion.PathPortionStart);
            PathPortionJson.SetFloatValue("PathPortionEnd", APathPortion.PathPortionEnd);
            PathPortionJson.SetFloatValue("Value", APathPortion.Value);

            PathPortionJson.SetIntValue("PathPortionType", int(APathPortion.PathPortionType));
        }
    }

    `Log(class'JsonObject'.static.EncodeJson(Json));
    ClientMessage("Check the log!");
}

function JsonObject Vec2Json(Vector vec)
{
    local JsonObject Json;

    Json = new class'JsonObject';
    Json.SetFloatValue("X", vec.X);
    Json.SetFloatValue("Y", vec.Y);
    Json.SetFloatValue("Z", vec.Z);
    return Json;
}

function JsonObject Guid2Json(Guid g)
{
    local JsonObject Json;

    Json = new class'JsonObject';
    Json.SetIntValue("A", g.A);
    Json.SetIntValue("B", g.B);
    Json.SetIntValue("C", g.C);
    Json.SetIntValue("D", g.D);
    return Json;
}