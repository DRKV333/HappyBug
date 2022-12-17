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

exec function HBGhost()
{
    bCollideWorld = !bCollideWorld;
    if (bCollideWorld)
    {
        ClientMessage("World collision enabled.");
    }
    else
    {
        ClientMessage("World collision disabled.");
    }
}

exec function HBSpeed(float NewSpeed = -1)
{
    if (NewSpeed == -1)
    {
        if (SpectatorCameraSpeed < 1000)
        {
            SpectatorCameraSpeed = 5000;
        }
        else
        {
            SpectatorCameraSpeed = 600;
        }
    }
    else
    {
        SpectatorCameraSpeed = NewSpeed;
    }

    ClientMessage("Set camera speed to"@SpectatorCameraSpeed);
}