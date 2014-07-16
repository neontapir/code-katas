namespace Neontapir
open Robocode
open System

type ActionType =
    | EndGame 
    | Search
    | Evade of float
    | Attack of float
    | AvoidWall

type BetaFish() = 
    inherit Robot()
    
    let random = Random(DateTime.Now.Millisecond)
    let defaultFirepower = 1.0
    let moveUnit = 20.0
    
    // the battle runner expects a single instance of a class,
    // so I have no way to return a new BetaFish()
    // instead, I mutate a state variable
    let mutable myAction : ActionType = Search 

    let randomTurn amount (robot:Robot) =
        let direction = random.Next 2 
        match direction with
        | 0 -> robot.TurnRight amount            
        | 1 -> robot.TurnLeft amount
        | _ -> failwith "Unexpected direction value"

    let shouldEvade enemyBearing =
        match enemyBearing with
        | bearing when Math.Abs(bearing : float) < 20.0 -> false
        | _ -> true

    let avoidWall (robot:Robot) =
        robot.Back moveUnit
        robot |> randomTurn 30.0

    let faceEnemy enemyBearing (robot:Robot) =
        robot.TurnRight enemyBearing
        robot.TurnGunRight robot.Heading

    let evade enemyBearing (robot:Robot) =
//        match enemyBearing with       
//        | bearing when shouldEvade bearing -> 
//            //robot |> randomTurn 90.0
            robot.Ahead moveUnit
            robot |> faceEnemy enemyBearing
            myAction <- Attack defaultFirepower
//        | _ -> 
//            robot.TurnRight enemyBearing
//            myAction <- Attack defaultFirepower

    override robot.Run() =         
        try
            while true do
                match myAction with
                | EndGame -> ()
                | AvoidWall ->
                    robot |> avoidWall
                    myAction <- Search            
                | Evade enemyBearing ->
                    robot |> evade enemyBearing
                    myAction <- Attack defaultFirepower
                    //myAction <- Search
                | Attack firepower -> 
                    robot.Fire firepower                
                | Search 
                | _ ->                            
                    robot.Ahead moveUnit
                    robot.TurnGunRight 40.0
        with _ -> 
            myAction <- EndGame

    override robot.OnScannedRobot(event) =
        match myAction with
        | Attack _ -> () // robot.Out.WriteLine "Scanned robot"
        | _ ->
            robot |> faceEnemy event.Bearing
            myAction <- Attack defaultFirepower
    
    override robot.OnBulletHit(event) =
        let newEvent = 
            match myAction with
//            | Attack oldPower ->
//                let maxPower = Rules.MAX_BULLET_POWER
//                match oldPower with
//                | x when x = maxPower -> Search
//                | _ -> 
//                    let power = Math.Min(oldPower + defaultFirepower, Rules.MAX_BULLET_POWER)            
//                    Attack power
            | _ -> Attack 3.0 //defaultFirepower        
        myAction <- newEvent
           
    override robot.OnBulletMissed(event) = 
        myAction <- Search

    override robot.OnHitByBullet(event) =
        if (shouldEvade event.Bearing) then myAction <- Evade(event.Bearing) 

    override robot.OnHitWall(event) =
        myAction <- AvoidWall

    override robot.OnDeath(event) =
        myAction <- EndGame

    override robot.OnBattleEnded(event) =
        myAction <- EndGame