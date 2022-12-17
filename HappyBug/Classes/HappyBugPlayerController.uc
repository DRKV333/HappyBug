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