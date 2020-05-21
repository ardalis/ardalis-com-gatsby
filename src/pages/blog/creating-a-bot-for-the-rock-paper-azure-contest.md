---
templateKey: blog-post
title: Creating a Bot for the Rock Paper Azure Contest
path: blog-post
date: 2011-04-18T20:43:00.000Z
description: "The Windows Azure team is holding a contest, and The Code Project
  is helping to support it.  As part of this contest, you can get free Azure
  compute time by signing up with the code CP001 here.  "
featuredpost: false
featuredimage: /img/azure-logo.png
tags:
  - azure
category:
  - Software Development
comments: true
share: true
---
The Windows Azure team is holding a contest, and [The Code Project](http://codeproject.com/) is helping to support it. As part of this contest, you can get [free Azure compute time by signing up with the code CP001 here](http://www.windowsazurepass.com/?campid=6229197A-3A45-E011-98E3-001F29C8E9A8). The contest is simple – Rock, Paper, Scissors, with bots, and with 2 new moves: Dynamite, which beats Rock, Paper, or Scissors, and Water Balloon, which beats Dynamite. The catch: you only have a limited supply of dynamite.

Get Started Here:

[![image](<> "image")](http://www.rockpaperazure.com/)

My bot placed 4th out of about 50 in last week’s contest (look for **ardalis**, the same as my [twitter handle](http://twitter.com/ardalis)). I’m hoping to be in the top 3 this week. I thought I’d share some tips to help you get started.

**Countering an Expected Move**

If you think you can predict what the other bot is going to do, then it’s a relatively simple matter to counter that move. Calculating the move to use to counter that move is fairly straightforward. In my initial design, I had a simple method that achieved this, but as my basic bot class grew in size, I refactored this out into its own simple class that follows the Single Responsibility Principle:

```
<span style="color: #0000ff">using</span> RockPaperScissorsPro;
&#160;

<span style="color: #0000ff">namespace</span> RockPaperAzure
{
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> CounterMove
{
<span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> Move _moveToCounter;

&#160;
<span style="color: #0000ff">public</span> CounterMove(Move moveToCounter)
    {

 _moveToCounter = moveToCounter;

        }

&#160;
    <span style="color: #0000ff">public</span> Move Result()
    {
     <span style="color: #0000ff">if</span> (_moveToCounter == Moves.Dynamite)

            {
             <span style="color: #0000ff">return</span> Moves.WaterBalloon;

            }

            <span style="color: #0000ff">if</span> (_moveToCounter == Moves.Rock)

            {
           <span style="color: #0000ff">return</span> Moves.Paper;

            }

            <span style="color: #0000ff">if</span> (_moveToCounter == Moves.Paper)

            {
          <span style="color: #0000ff">return</span> Moves.Scissors;

            }

            <span style="color: #0000ff">if</span> (_moveToCounter == Moves.Scissors)

            {

                <span style="color: #0000ff">return</span> Moves.Rock;

            }
         <span style="color: #0000ff">if</span> (_moveToCounter == Moves.WaterBalloon)
          {

                <span style="color: #0000ff">return</span> Moves.GetRandomMove();

            }

            <span style="color: #0000ff">return</span> Moves.GetRandomMove();

        }

&#160;

    }

}
```

Note that this will never return Dynamite as a counter move – I’m assuming that you’ll have your own special logic for determining when you’d like to use your Dynamite.

**Tracking Game State**

The MakeMove method accepts two IPlayer instances and a GameRules instance that pretty much just includes constants (like how much Dynamite each player has). The player instances will let you know their last move, points, whether they have Dynamite remaining, etc., but notably will not provide you with a complete history of the game, except as a text log. Thus, if you’re interested in knowing the current state of the game, or how your opponent reacted when faced with similar game state in the past, you’ll need to track this yourself. The simplest thing you can do is create a couple of arrays or lists of moves for yourself and your opponent, but eventually you have enough game state tracking logic that it makes sense to move it to its own class as well. Thus, you might find something like the GameState class useful. This class lets me inspect my own move history, my opponent’s move history, how many of a given move my opponent has made, and also what my opponent’s response was to a given Tie scenario, such as tied once, tied twice, tied three times, etc.

```
<span style="color: #0000ff">using</span> System.Collections.Generic;
<span style="color: #0000ff">using</span> RockPaperScissorsPro;
<span style="color: #0000ff">using</span> System.Linq;
&#160;
<span style="color: #0000ff">namespace</span> RockPaperAzure
{
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> GameState

{
<span style="color: #0000ff">public</span> List&lt;Move&gt; MyMoves = <span style="color: #0000ff">new</span> List&lt;Move&gt;();
<span style="color: #0000ff">public</span> List&lt;Move&gt; OpponentMoves = <span style="color: #0000ff">new</span> List&lt;Move&gt;();
<span style="color: #0000ff">public</span> Dictionary&lt;<span style="color: #0000ff">int</span>, List&lt;Move&gt;&gt; OpponentTieResponse = <span style="color: #0000ff">new</span> Dictionary&lt;<span style="color: #0000ff">int</span>, List&lt;Move&gt;&gt;();
<span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> CurrentTieCount = 0;

&#160;
 <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Update(IPlayer you, IPlayer opponent)
{
MyMoves.Add(you.LastMove);
OpponentMoves.Add(opponent.LastMove);
 <span style="color: #0000ff">if</span> (CurrentTieCount &gt; 0)
 {
 <span style="color: #0000ff">if</span> (!OpponentTieResponse.ContainsKey(CurrentTieCount))
 {

 OpponentTieResponse[CurrentTieCount] = <span style="color: #0000ff">new</span> List&lt;Move&gt;();

 }

 OpponentTieResponse[CurrentTieCount].Add(opponent.LastMove);

 }

            <span style="color: #0000ff">if</span> (you.LastMove == opponent.LastMove) <span style="color: #008000">// tie</span>

            {
             CurrentTieCount++;
        }

            <span style="color: #0000ff">else</span>
        {

                CurrentTieCount = 0;

            }

        }


&#160;
<span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> MovesMadeByOpponent(Move move)
 {
<span style="color: #0000ff">return</span> OpponentMoves.Count(m =&gt; m == move);
 }
}

}
```

**Countering a Particular Bot**

If you find that one particular bot is foiling your primary strategy, you can target that bot specifically. For instance, at one point early in the contest last week I reviewed the log of a match I’d lost to a player named mitchmilam. After looking at the log, I noticed that his bot simply countered whatever move I made previously. Knowing this, I thought I’d test out a bot that countered the counter of whatever move it had just made – the CounterCounterBot was born. However, I didn’t want to run this bot against everybody – only against mitchmilam (and perhaps later against any bot I determined to be a CounterBot). To make this work, I simply added this case to my MakeMove() method:

```
<span style="color: #0000ff">if</span> (opponent.TeamName == <span style="color: #006080">&quot;mitchmilam&quot;</span>)
{
<span style="color: #0000ff">return</span> CounterMitchMilam(you, opponent);

}
```

and then wrote this method:

```
<span style="color: #0000ff">private</span> Move CounterMitchMilam(IPlayer you, IPlayer opponent)
{
<span style="color: #0000ff">if</span> (_gameState.CurrentTieCount == 1 && opponent.HasDynamite)
{
<span style="color: #0000ff">return</span> Moves.WaterBalloon;
 }
<span style="color: #0000ff">if</span> (ShouldThrowDynamiteIncreasingChanceWithTies(you))
 {
<span style="color: #0000ff">return</span> Moves.Dynamite;
}
<span style="color: #0000ff">if</span> (Moves.GetRandomNumber(10) &lt; 8)
{
 <span style="color: #0000ff">return</span> <span style="color: #0000ff">new</span> CounterMove(<span style="color: #0000ff">new</span> CounterMove(you.LastMove).Result()).Result();    }

 <span style="color: #0000ff">return</span> Moves.GetRandomMove();

}
```

The result? In the next matchup between our bots, my bot won 1000 to 2. Later, this bot updated its strategy a bit…

**Summary**

If you’re interested in getting started with Windows Azure or just want to try your skill at creating a simple AI bot to play a very simple game, give the contest a go. There are some prizes if you’re in the top 3 in a given week (only for US residents, I’m afraid), but it’s also a fun test of skill and if you get your friends to play you can earn some bragging rights. Good luck!