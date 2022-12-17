class HappyBugGameInfo extends GameInfo;

DefaultProperties
{
    PlayerControllerClass=class'HappyBugPlayerController'
}

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
{
    local NavigationPoint start;

    start = Super.FindPlayerStart(Player, InTeam, IncomingName);
    if (start != none)
        return start;

    `log("No start point found, returning a fake one...");

    return Spawn(class'SpawnableNavigationPoint',,,,,,true);
}