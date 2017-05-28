module.exports = (robot) ->
     
   robot.hear /tesla/i, (res) ->
     res.send "I am giving out internship oppurtunities for tesla."
   
   robot.hear /spacex/i, (res) ->
     res.send "SpaceX is cool. Gonna go to Mars."
     
   robot.hear /breakfast/i, (res) ->
     res.send 'Breakfast is  at 8:00am'
     
   robot.hear /lunch/i, (res) ->
     res.send 'Lunch is at 12:00pm'
   
   robot.hear /dinner/i, (res) ->
     res.send 'Dinner is at 6:00pm'
     
   robot.hear /name/i, (res) ->
     res.send "Hi #{res.message.user.name}"
     
    robot.hear /team/i, (res) ->
     res.send "Hi #{res.message.user.name}. Unfortunately I'm too preoccupied to team."
    
   robot.hear /waterloo/i, (res) ->
     res.send "I was going to do physics and engineering at Waterloo, but then I visited the campus… and, you may not want to print this… but there didn’t seem to be any girls there!"
   
   robot.hear /uoft/i, (res) ->
     res.send "I considered Waterloo and Queens. UofT was never an option. I think if you want to make as much moolah as me, you gotta consider your options wisely."
     
   robot.hear /queens/i, (res) ->
     res.send "Queens is the best university in the world! I chose it for the vibrant communities and amazing programs. MAKE QUEENS GREAT AGAIN!"
     
   robot.hear /york/i, (res) ->
     res.send "York is a nice place."
   
   robot.hear /ryerson/i, (res) ->
     res.send "Ryerson is a nice place."
     
   robot.hear /schedule/i, (res) ->
     res.send 'Read the schedule here: http://enghack.uwaterloo.ca'

   robot.respond /open the (.*) doors/i, (res) ->
     doorType = res.match[1]
     if doorType is "pod bay"
       res.reply "I'm afraid I can't let you do that."
     else
       res.reply "Opening #{doorType} doors"
  
   robot.hear /I like pie/i, (res) ->
     res.emote "makes a freshly baked pie with SpaceX money"

   quotes = ['Patience is a virtue, and I\'m learning patience. It\'s a tough lesson.', 'I would like to die on Mars. Just not on impact.', 'I think life on Earth must be about more than just solving problems... It\'s got to be something inspiring, even if it is vicarious.', 'If you\'re trying to create a company, it\'s like baking a cake. You have to have all the ingredients in the right proportion.', 'It\'s OK to have your eggs in one basket as long as you control what happens to that basket.', 'An asteroid or a supervolcano could certainly destroy us, but we also face risks the dinosaurs never saw: An engineered virus, nuclear war, inadvertent creation of a micro black hole, or some as-yet-unknown technology could spell the end of us.']
   
   songs = ['Now listen closely\, Here\'s a little lesson in trickery\, This is going down in history\, If you wanna be a Villain Number One\, You have to chase a superhero on the run\, Just follow my moves\, and sneak around\, Be careful not to make a sound\, (Shh)\, (No\, don\'t touch that!)']

   robot.hear /quote/i, (res) ->
     res.send res.random quotes

   robot.hear /help/i, (res) ->
     res.emote "I am here to help everyone"
     
   robot.hear /song/i, (res) ->
     res.emote res.random songs

   lulz = ['lol', 'rofl', 'lmao']
  
   robot.hear /lulz/i, (res) ->
     res.send res.random lulz
  
   robot.topic (res) ->
     res.send "#{res.message.text}? That's a Paddlin'"
  
  
   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  
   answer = 'I think the high-tech industry is used to developing new things very quickly. It\'s the Silicon Valley way of doing business: You either move very quickly and you work hard to improve your product technology, or you get destroyed by some other company.'
  
   robot.respond /what is the answer to the ultimate question of life/, (res) ->
     unless answer?
       res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
       return
     res.send "#{answer}, but what is the question?"
  
   robot.respond /you are a little slow/, (res) ->
     setTimeout () ->
       res.send "Who you calling 'slow'?"
     , 60 * 1000
  
   annoyIntervalId = null
  
   robot.respond /concatem/, (res) ->
     if annoyIntervalId
       res.send "Queens is better!"
       return
  
     res.send "Hmmmmm"
     annoyIntervalId = setInterval () ->
       res.send "I was going to do physics and engineering at Waterloo, but then I visited the campus… and, you may not want to print this… but there didn’t seem to be any girls there!"
     , 2
  
   robot.respond /unannoy me/, (res) ->
     if annoyIntervalId
       res.send "GUYS, GUYS, GUYS!"
       clearInterval(annoyIntervalId)
       annoyIntervalId = null
     else
       res.send "Not annoying you right now, am I?"
  
  
   robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
     room   = req.params.room
     data   = JSON.parse req.body.payload
     secret = data.secret
  
     robot.messageRoom room, "I have a secret: #{secret}"
  
     res.send 'OK'
  
   robot.error (err, res) ->
     robot.logger.error "DOES NOT COMPUTE"
  
     if res?
       res.reply "DOES NOT COMPUTE"
  
   robot.respond /have a soda/i, (res) ->
     # Get number of sodas had (coerced to a number).
     sodasHad = robot.brain.get('totalSodas') * 1 or 0
  
     if sodasHad > 4
       res.reply "I'm too fizzy.."
  
     else
       res.reply 'Sure!'
  
       robot.brain.set 'totalSodas', sodasHad+1
  
   robot.respond /sleep it off/i, (res) ->
     robot.brain.set 'totalSodas', 0
     res.reply 'zzzzz'
