%June 11, 2018
%Sophia Nguyen
%Ms. Krasteva
%This program runs a driving simulation game, where the user must control a car through a town to get home from school.

%Revisions List
%changed and added comments
%removed a for loop in process play music
%changed blueCarFinished variable name to otherCarsFinished
%moved nested if statements for otherCarsFinished outside to its separate if statements
%added a global variable 'finished' to determine when to stop music
%added two 'exit when finished' inside the play music loop
%added finished := true and Music.PlayFileStop at the end of the main program
%added a third option for display and made the red light traps lead to there
%added police siren sound, jack in the box sound, and closing door sound to playGame
%added a delay between jack in the box sound and closing door sound
%added and changed text of display screens
%moved Window.Hide (displayWindow) to the top of introduction
%removed a rectangle in the playGame design
%changed lastKey := lastKey + 1 to lastKey := lastKey + 2
%made the other cars move up 30 pixels more
%changed coordinates for crashing into other cars traps
%moved setscreen ("nocursor") from playGame to screen set up
%changed several font styles
%added colorback to display
%rearranged position of variables
%added and took away View.Updates
%changed instructions text and added pictures to instructions
%added pedestrian pictures, variables for the pedestrian, pedestrian animation, pedestrian movement changes, and trapping for when the user crashes into pedestrians
%added buildings, a moon, and stars to the introduction animation
%changed variable, title, Pic.Scale, GUI.Hide positions in the code
%added more text and design to the display screens

%Sets screen up
import GUI
%sets the screen so that text and graphics are drawn offscreen
setscreen ("offscreenonly")
%sets the screen so keys that the user inputs doesn't echo
setscreen ("noecho")
%sets the screen so that there is no cursor
setscreen ("nocursor")

%forward procedures
forward procedure mainMenu
forward procedure instructions
forward procedure playGame

%Declaration Section
%this is the GUI button to go to the main menu
var mainMenuButton : int := 0
%this is the GUI button to display the game instructions
var instructionsButton : int := 0
%this is the GUI button to start playing the game
var playGameButton : int := 0
%this is the GUI button to exit the game to the goodbye screen
var quitButton : int := 0
%this creates the display window
var displayWindow := Window.Open ("position:300;200,graphics:300,400")
%this creates the main window
var mainWindow := Window.Open ("position:300;200,graphics:640,400")
%this stores true or false for every key so we can check for the live keyboard input
var chars : array char of boolean
%this stores how many times the screen has been updated since the last key press
var lastKey : int := 5
%this determines whether the music playing is finished or not
var finished : boolean := false

%plays background music for the program
process playMusic
    loop
	%first music file
	Music.PlayFile ("upbeatMusic.wav")
	exit when finished
	%second music file
	Music.PlayFile ("upbeatMusic2.wav")
	exit when finished
    end loop
end playMusic

%creates the title of the program, which clears the screen
procedure title
    %clears the screen
    cls
end title

%creates the introduction of the program, which welcomes the user, shows an animation, and shows a button leading to the main menu
procedure introduction
    %variable declarations
    var welcomeFont : int := Font.New ("Levenim MT:18:bold")
    var introPic : int := Pic.FileNew ("speedingCar.bmp")
    %hides the display window
    Window.Hide (displayWindow)
    %colours the background blue
    colorback (55)
    %clears the screen
    title
    %road
    drawfillbox (0, 0, 640, 210, 28)
    %first building from the left
    drawfillbox (0, 211, 100, 350, 20)
    %second building from the left
    drawfillbox (100, 211, 200, 400, 20)
    %third building from the left
    drawfillbox (200, 211, 280, 260, 20)
    %fourth building from the left
    drawfillbox (280, 211, 360, 300, 20)
    %grass
    drawfillbox (361, 211, 640, 230, green)
    %moon
    drawfilloval (575, 360, 15, 15, white)
    %star #1 from the left
    drawfilloval (235, 375, 1, 1, yellow)
    %star #2
    drawfilloval (275, 325, 1, 1, yellow)
    %star #3
    drawfilloval (320, 350, 1, 1, yellow)
    %star #4
    drawfilloval (400, 325, 1, 1, yellow)
    %star #5
    drawfilloval (450, 380, 1, 1, yellow)
    %star #6
    drawfilloval (480, 287, 1, 1, yellow)
    %star #7
    drawfilloval (500, 350, 1, 1, yellow)
    %star #8
    drawfilloval (550, 325, 1, 1, yellow)
    %star #9
    drawfilloval (600, 275, 1, 1, yellow)
    %draws and animates a car
    for i : 0 .. 500
	drawfillbox (-356 + i, 70, -40 + i, 200, 28) %erase
	drawfillbox (-320 + i, 90, -80 + i, 151, red) %middle
	drawfillarc (-222 + i, 150, 105, 50, 0, 180, red) %top
	drawfillarc (-100 + i, 150, 50, 50, 143, 280, red) %front slope
	drawfillarc (-105 + i, 117, 65, 38, 270, 90, red) %front
	Draw.ThickLine (-150 + i, 183, -110 + i, 154, 10, 102) %front window
	drawfillarc (-300 + i, 125, 55, 40, 90, 270, red) %back
	drawfillarc (-342 + i, 150, 50, 50, 300, 37, red) %back slope
	drawfillarc (-225 + i, 147, 78, 48, 0, 180, black) %side windows outline
	drawfillarc (-225 + i, 150, 75, 40, 0, 180, 102) %side windows
	Draw.ThickLine (-225 + i, 150, -225 + i, 190, 3, black) %side window divider
	Draw.ThickLine (-224 + i, 95, -224 + i, 140, 2, black) %car doors divider
	drawfillarc (-300 + i, 100, 30, 30, 90 - i, 270 - i, black) %left wheel left arc
	drawfillarc (-300 + i, 100, 30, 30, 270 - i, 90 - i, 20) %left wheel right arc
	drawfilloval (-300 + i, 100, 20, 20, 29) %inside of left wheel
	drawfilloval (-300 + i, 100, 5, 5, 30) %center of left wheel
	drawfillarc (-100 + i, 100, 30, 30, 90 - i, 270 - i, black) %right wheel left arc
	drawfillarc (-100 + i, 100, 30, 30, 270 - i, 90 - i, 20) %right wheel right arc
	drawfilloval (-100 + i, 100, 20, 20, 29) %inside of right wheel
	drawfilloval (-100 + i, 100, 5, 5, 30) %center of right wheel
	View.Update
	%delay (10)
    end for
    %car honk sound
    Music.PlayFile ("carHonk.wav")
    for i : 0 .. 200
	%screen closes to become a black background
	drawfillbox (0, 400 - i, 640, 800 - i, black)
	drawfillbox (0, -200 + i, 640, 0 + i, black)
	View.Update
	%delay (10)
    end for
    %scales the introduction picture to the screen size
    introPic := Pic.Scale (introPic, 640, 400)
    %draws the background picture
    Pic.Draw (introPic, 0, 0, picMerge)
    %draws the weclome text
    Draw.Text ("Welcome to the Driving Simulation Game!", 72, 190, welcomeFont, white)
    %main menu button
    mainMenuButton := GUI.CreateButton (275, 130, 0, "Main Menu", mainMenu)
    %starts the music loop
    fork playMusic
end introduction

%creates the main menu of the program, where the user can choose to play the game, look at the instructions, or quit the program
body procedure mainMenu
    %variable declaration
    var mainMenuPic : int := Pic.FileNew ("mainMenuCar.bmp")
    %hides the display window
    Window.Hide (displayWindow)
    %shows the main window
    Window.Show (mainWindow)
    %selects the main window so we can use it
    Window.Select (mainWindow)
    %clears the screen
    title
    %hides the main menu button
    GUI.Hide (mainMenuButton)
    %scales the main menu picture to the screen size
    mainMenuPic := Pic.Scale (mainMenuPic, 640, 400)
    %draws the background picture
    Pic.Draw (mainMenuPic, 0, 0, picMerge)
    %quit button
    quitButton := GUI.CreateButton (290, 150, 0, "Quit", GUI.Quit)
    %play game button
    playGameButton := GUI.CreateButton (275, 250, 0, "Play Game", playGame)
    %instructions button
    instructionsButton := GUI.CreateButton (273, 200, 0, "Instructions", instructions)
end mainMenu

%creates the instructions of the game
body procedure instructions
    %variable declarations
    var instructionsFont : int := Font.New ("Kalinga:12:bold")
    var arrowKeysPic : int := Pic.FileNew ("arrowKeys.bmp")
    var instructionsPic : int := Pic.FileNew ("instructionsCar.bmp")
    %clears the screen
    title
    %hides the play game button
    GUI.Hide (playGameButton)
    %hides the instructions button
    GUI.Hide (instructionsButton)
    %hides the quit button
    GUI.Hide (quitButton)
    %scales the instructions picture to the screen size
    instructionsPic := Pic.Scale (instructionsPic, 640, 400)
    %draws the instructions background picture
    Pic.Draw (instructionsPic, 0, 0, picMerge)
    %draws instructions text
    locate (4, 1)
    Draw.Text ("Instructions:", 10, 330, instructionsFont, white)
    Draw.Text ("You are driving your car home from school. You must get home safely", 10, 300, instructionsFont, white)
    Draw.Text ("without getting into a car accident or breaking the law to win the game.", 10, 280, instructionsFont, white)
    Draw.Text ("Use the arrow keys (up, down, left, and right) to move the car", 10, 250, instructionsFont, white)
    %scales the arrow keys picture to the screen size
    arrowKeysPic := Pic.Scale (arrowKeysPic, 80, 50)
    %draws the arrow keys picture
    Pic.Draw (arrowKeysPic, 500, 215, picMerge)
    %instructions text
    Draw.Text ("throughout the town streets.", 10, 230, instructionsFont, white)
    Draw.Text ("Do not crash into the green areas! These are sidewalks and buildings.", 10, 190, instructionsFont, white)
    %draws a rectangular green area
    drawfillbox (560, 170, 605, 210, green)
    %instructions text
    Draw.Text ("This is your red car.", 10, 160, instructionsFont, white)
    %draws a red car
    drawfillarc (192, 170, 15, 10, 0, 180, red)  %car top
    drawfillbox (177, 160, 207, 170, red)        %car middle
    Draw.ThickLine (181, 170, 203, 170, 6, 77)   %window
    drawfilloval (182, 160, 3, 3, black)         %left wheel
    drawfilloval (202, 160, 3, 3, black)         %right wheel
    Draw.Text ("There are other cars driving on the streets. Do not crash into them!", 10, 140, instructionsFont, white)
    %draws a yellow car
    drawfillarc (562, 140, 15, 10, 0, 180, yellow) %car top
    drawfillbox (547, 130, 577, 140, yellow)       %car middle
    Draw.ThickLine (551, 140, 573, 140, 6, 77)     %window
    drawfilloval (552, 130, 3, 3, black)           %left wheel
    drawfilloval (572, 130, 3, 3, black)           %right wheel
    %draws a blue car
    drawfillarc (602, 140, 15, 10, 0, 180, blue)  %car top
    drawfillbox (587, 130, 617, 140, blue)        %car middle
    Draw.ThickLine (591, 140, 613, 140, 6, 77)    %window
    drawfilloval (592, 130, 3, 3, black)          %left wheel
    drawfilloval (612, 130, 3, 3, black)          %right wheel
    %instructions text
    Draw.Text ("Obey traffic lights! Green means go, yellow means slow down,", 10, 110, instructionsFont, white)
    Draw.Text ("and red means stop. Don't drive through red lights!", 10, 90, instructionsFont, white)
    %draws a green light
    drawfillbox (520, 85, 540, 125, 22) %traffic light back
    drawfilloval (530, 95, 4, 4, 46) %green light
    drawfilloval (530, 105, 4, 4, 28) %yellow light cover
    drawfilloval (530, 115, 4, 4, 28) %red light cover
    %draws a yellow light
    drawfillbox (550, 85, 570, 125, 22) %traffic light back
    drawfilloval (560, 95, 4, 4, 28) %green light cover
    drawfilloval (560, 105, 4, 4, 67) %yellow light
    drawfilloval (560, 115, 4, 4, 28) %red light cover
    %draws a red light
    drawfillbox (580, 85, 600, 125, 22) %traffic light back
    drawfilloval (590, 95, 4, 4, 28) %green light cover
    drawfilloval (590, 105, 4, 4, 28) %yellow light cover
    drawfilloval (590, 115, 4, 4, 12) %red light
    %instructions text
    Draw.Text ("Be careful of jaywalking pedestrians. Do not crash into them!", 10, 60, instructionsFont, white)
    %main menu button
    mainMenuButton := GUI.CreateButton (275, 10, 0, "Main Menu", mainMenu)
end instructions

%creates the ending of the game (shows that the user won or lost the game)
procedure display (outcomeNumber : int)
    %variable declarations
    var titleFont : int := Font.New ("Impact:15:bold,italic,underline")
    var displayFont : int := Font.New ("Calibri:13:bold")
    %hides the main window
    Window.Hide (mainWindow)
    %shows the display window
    Window.Show (displayWindow)
    %selects the display window so we can use it
    Window.Select (displayWindow)
    %colours the background pink
    colorback (89)
    %clears the screen
    title
    %draws the title
    Draw.Text ("Driving Simulation Game", 40, 380, titleFont, red)
    %output statements using an if structure
    if outcomeNumber = 1 then
	%the user wins the game
	%output text
	Draw.Text ("Congratulations!!!", 85, 300, displayFont, black)
	Draw.Text ("You managed to drive home without", 20, 280, displayFont, black)
	Draw.Text ("getting into an accident or breaking the", 10, 260, displayFont, black)
	Draw.Text ("law. You are safely home at last!", 30, 240, displayFont, black)
	Draw.Text ("You won the game!", 80, 220, displayFont, black)
    elsif outcomeNumber = 2 then
	%the user gets into a car accident and loses the game
	%output text
	Draw.Text ("Sorry, you got into a car accident.", 30, 300, displayFont, black)
	Draw.Text ("Better luck next time!", 70, 280, displayFont, black)
    elsif outcomeNumber = 3 then
	%the user drives past a red light and loses the game
	%output text
	Draw.Text ("Sorry, you got a parking ticket because", 10, 300, displayFont, black)
	Draw.Text ("you went past a red light.", 60, 280, displayFont, black)
	Draw.Text ("Better luck next time!", 70, 260, displayFont, black)
    end if
    %main menu button
    mainMenuButton := GUI.CreateButton (100, 150, 0, "Main Menu", mainMenu)
end display

%creates the game and lets the user interact with/play the game
body procedure playGame
    %variable declarations
    var timeCounter : int := 0
    %main car
    var startCarMiddleX : int := 27
    var endCarMiddleX : int := 57
    var startWindowX : int := 31
    var carTopX : int := 42
    var carTopY, endCarMiddleY, startWindowY, endWindowY : int := 40
    var endWindowX : int := 53
    var leftWheelX : int := 32
    var startCarMiddleY, leftWheelY, rightWheelY : int := 30
    var rightWheelX : int := 52
    %other cars
    var carTopX2 : int := 200
    var carTopY2, endCarMiddleY2, startWindowY2, endWindowY2 : int := 220
    var startCarMiddleX2 : int := 185
    var endCarMiddleX2 : int := 215
    var startWindowX2 : int := 189
    var endWindowX2 : int := 211
    var leftWheelX2 : int := 190
    var startCarMiddleY2, leftWheelY2, rightWheelX2, rightWheelY2 : int := 210
    var otherCarsFinished : boolean := false
    %traffic lights
    var greenLight1On, yellowLight2On, redLight3On : boolean := true
    var yellowLight1On, redLight1On, greenLight2On, redLight2On, yellowLight3On, greenLight3On : boolean := false
    %pedestrians
    var pedestrianPic : int := Pic.FileNew ("pedestrian.bmp")
    pedestrianPic := Pic.Scale (pedestrianPic, 25, 25)
    var pedestrian1X : int := 250
    var pedestrianY : int := 348
    var pedestrian2X : int := 28
    var endPedestrian1X : int := Pic.Width (pedestrianPic) + 250
    var endPedestrianY : int := Pic.Height (pedestrianPic) + 348
    var endPedestrian2X : int := Pic.Width (pedestrianPic) + 25
    var pedestrian1Finished : boolean := false
    var pedestrian2Finished : boolean := false
    %other pictures
    var schoolPic : int := Pic.FileNew ("school.bmp") %school picture
    schoolPic := Pic.Scale (schoolPic, 50, 50)
    var homePic : int := Pic.FileNew ("house.bmp") %home picture
    homePic := Pic.Scale (homePic, 60, 55)
    var gamePic : int := Pic.FileNew ("trees.bmp") %background picture
    gamePic := Pic.Scale (gamePic, 640, 400)
    %clears the screen
    title
    %hides buttons
    GUI.Hide (playGameButton)
    GUI.Hide (instructionsButton)
    GUI.Hide (quitButton)
    %draws the background picture
    Pic.Draw (gamePic, 0, 0, picMerge)
    drawfillbox (25, 25, 615, 375, 30)      %roads background
    drawfillbox (60, 54, 100, 346, 144)     %grass #1
    drawfillbox (140, 54, 180, 210, 144)    %grass #2
    drawfillbox (150, 250, 250, 346, 144)   %grass #3
    drawfillbox (220, 54, 260, 210, 144)    %grass #4
    drawfillbox (300, 54, 340, 346, 144)    %grass #5
    drawfillbox (380, 25, 420, 317, 144)    %grass #6
    drawfillbox (460, 83, 500, 375, 144)    %grass #7
    drawfillbox (460, 60, 580, 120, 144)    %grass #8
    drawfillbox (540, 153, 615, 190, 144)   %grass #9
    drawfillbox (538, 225, 578, 340, 144)   %grass #10
    Pic.Draw (schoolPic, -10, -10, picMerge) %school picture
    Pic.Draw (homePic, 575, 340, picMerge)  %home picture
    %Traffic Light #1
    drawfillbox (70, 160, 90, 200, 22) %traffic light back
    drawfilloval (80, 170, 4, 4, 46) %green light
    drawfilloval (80, 180, 4, 4, 28) %yellow light cover
    drawfilloval (80, 190, 4, 4, 28) %red light cover
    %Traffic Light #2
    drawfillbox (190, 305, 210, 345, 22) %traffic light back
    drawfilloval (200, 315, 4, 4, 28) %green light cover
    drawfilloval (200, 325, 4, 4, 67) %yellow light
    drawfilloval (200, 335, 4, 4, 28) %red light cover
    %Traffic Light #3
    drawfillbox (390, 175, 410, 215, 22) %traffic light back
    drawfilloval (400, 185, 4, 4, 28) %green light cover
    drawfilloval (400, 195, 4, 4, 28) %yellow light cover
    drawfilloval (400, 205, 4, 4, 12) %red light
    %main gameplay loop
    loop
	%draws pedestrian 1 (the pedestrian to the right)
	drawfillbox (pedestrian1X - 1, pedestrianY - 1, endPedestrian1X + 1, endPedestrianY + 1, 30) %erase
	Pic.Draw (pedestrianPic, pedestrian1X, pedestrianY, picMerge) %draw
	%draws pedestrian 2 (the pedestrian to the left)
	drawfillbox (pedestrian2X - 1, pedestrianY - 1, endPedestrian2X + 1, endPedestrianY + 1, 30) %erase
	Pic.Draw (pedestrianPic, pedestrian2X, pedestrianY, picMerge) %draw
	%draws the blue car
	drawfillbox (startCarMiddleX2 - 1, leftWheelY2 - 4, endCarMiddleX2 + 1, carTopY2 + 11, 30) %erase
	drawfillarc (carTopX2, carTopY2, 15, 10, 0, 180, blue)                                     %car top
	drawfillbox (startCarMiddleX2, startCarMiddleY2, endCarMiddleX2, endCarMiddleY2, blue)     %car middle
	Draw.ThickLine (startWindowX2, startWindowY2, endWindowX2, endWindowY2, 6, 77)             %window
	drawfilloval (leftWheelX2, leftWheelY2, 3, 3, black)                                       %left wheel
	drawfilloval (rightWheelX2, rightWheelY2, 3, 3, black)                                     %right wheel
	%draws the yellow car
	drawfillbox (startCarMiddleX2 + 79, leftWheelY2 - 4, endCarMiddleX2 + 81, carTopY2 + 11, 30)        %erase
	drawfillarc (carTopX2 + 80, carTopY2, 15, 10, 0, 180, yellow)                                       %car top
	drawfillbox (startCarMiddleX2 + 80, startCarMiddleY2, endCarMiddleX2 + 80, endCarMiddleY2, yellow)  %car middle
	Draw.ThickLine (startWindowX2 + 80, startWindowY2, endWindowX2 + 80, endWindowY2, 6, 77)            %window
	drawfilloval (leftWheelX2 + 80, leftWheelY2, 3, 3, black)                                           %left wheel
	drawfilloval (rightWheelX2 + 80, rightWheelY2, 3, 3, black)                                         %right wheel
	%draws the main car
	drawfillbox (startCarMiddleX - 1, leftWheelY - 4, endCarMiddleX + 1, carTopY + 11, 30)     %erase
	drawfillarc (carTopX, carTopY, 15, 10, 0, 180, red)                                        %car top
	drawfillbox (startCarMiddleX, startCarMiddleY, endCarMiddleX, endCarMiddleY, red)          %car middle
	Draw.ThickLine (startWindowX, startWindowY, endWindowX, endWindowY, 6, 77)                 %window
	drawfilloval (leftWheelX, leftWheelY, 3, 3, black)                                         %left wheel
	drawfilloval (rightWheelX, rightWheelY, 3, 3, black)                                       %right wheel
	View.Update
	%reads which keys are being pressed
	Input.KeyDown (chars)
	%moves the car depending on the user input, using an if statement structure
	if chars (chr (200)) and lastKey > 5 then
	    %moves the car up
	    carTopY := carTopY + 1
	    startCarMiddleY := startCarMiddleY + 1
	    endCarMiddleY := endCarMiddleY + 1
	    startWindowY := startWindowY + 1
	    endWindowY := endWindowY + 1
	    leftWheelY := leftWheelY + 1
	    rightWheelY := rightWheelY + 1
	    lastKey := 0
	elsif chars (chr (208)) and lastKey > 5 then
	    %moves the car down
	    carTopY := carTopY - 1
	    startCarMiddleY := startCarMiddleY - 1
	    endCarMiddleY := endCarMiddleY - 1
	    startWindowY := startWindowY - 1
	    endWindowY := endWindowY - 1
	    leftWheelY := leftWheelY - 1
	    rightWheelY := rightWheelY - 1
	    lastKey := 0
	elsif chars (chr (205)) and lastKey > 5 then
	    %moves the car right
	    carTopX := carTopX + 1
	    startCarMiddleX := startCarMiddleX + 1
	    endCarMiddleX := endCarMiddleX + 1
	    startWindowX := startWindowX + 1
	    endWindowX := endWindowX + 1
	    leftWheelX := leftWheelX + 1
	    rightWheelX := rightWheelX + 1
	    lastKey := 0
	elsif chars (chr (203)) and lastKey > 5 then
	    %moves the car left
	    carTopX := carTopX - 1
	    startCarMiddleX := startCarMiddleX - 1
	    endCarMiddleX := endCarMiddleX - 1
	    startWindowX := startWindowX - 1
	    endWindowX := endWindowX - 1
	    leftWheelX := leftWheelX - 1
	    rightWheelX := rightWheelX - 1
	    lastKey := 0
	end if
	View.Update
	%stops the user from moving the car off of the screen, using an if statement structure
	if startCarMiddleX < 26 then
	    %moves the car right if the user tries to go off the left of the screen
	    carTopX := carTopX + 1
	    startCarMiddleX := startCarMiddleX + 1
	    endCarMiddleX := endCarMiddleX + 1
	    startWindowX := startWindowX + 1
	    endWindowX := endWindowX + 1
	    leftWheelX := leftWheelX + 1
	    rightWheelX := rightWheelX + 1
	elsif endCarMiddleX > 614 then
	    %moves the car left if the user tries to go off the right of the screen
	    carTopX := carTopX - 1
	    startCarMiddleX := startCarMiddleX - 1
	    endCarMiddleX := endCarMiddleX - 1
	    startWindowX := startWindowX - 1
	    endWindowX := endWindowX - 1
	    leftWheelX := leftWheelX - 1
	    rightWheelX := rightWheelX - 1
	elsif leftWheelY < 30 then
	    %moves the car up if the user tries to go off the bottom of the screen
	    carTopY := carTopY + 1
	    startCarMiddleY := startCarMiddleY + 1
	    endCarMiddleY := endCarMiddleY + 1
	    startWindowY := startWindowY + 1
	    endWindowY := endWindowY + 1
	    leftWheelY := leftWheelY + 1
	    rightWheelY := rightWheelY + 1
	elsif carTopY > 364 then
	    %moves the car down if the user tries to go off the top of the screen
	    carTopY := carTopY - 1
	    startCarMiddleY := startCarMiddleY - 1
	    endCarMiddleY := endCarMiddleY - 1
	    startWindowY := startWindowY - 1
	    endWindowY := endWindowY - 1
	    leftWheelY := leftWheelY - 1
	    rightWheelY := rightWheelY - 1
	end if
	View.Update
	%Car Changes
	if timeCounter rem 5 = 0 then
	    if otherCarsFinished = true then
		%moves the other cars up
		carTopY2 := carTopY2 + 1
		endCarMiddleY2 := endCarMiddleY2 + 1
		startWindowY2 := startWindowY2 + 1
		endWindowY2 := endWindowY2 + 1
		startCarMiddleY2 := startCarMiddleY2 + 1
		leftWheelY2 := leftWheelY2 + 1
		rightWheelY2 := rightWheelY2 + 1
	    elsif otherCarsFinished = false then
		%moves the other cars down
		carTopY2 := carTopY2 - 1
		endCarMiddleY2 := endCarMiddleY2 - 1
		startWindowY2 := startWindowY2 - 1
		endWindowY2 := endWindowY2 - 1
		startCarMiddleY2 := startCarMiddleY2 - 1
		leftWheelY2 := leftWheelY2 - 1
		rightWheelY2 := rightWheelY2 - 1
	    end if
	    if carTopY2 > 230 then
		%other cars haven't finished travelling down
		otherCarsFinished := false
	    elsif carTopY2 < 45 then
		%other cars have finished travelling down, so they can start to travel up
		otherCarsFinished := true
	    end if
	end if
	%Pedestrian Changes
	if timeCounter rem 10 = 0 then
	    if pedestrian1Finished = true then
		%moves pedestrian 1 left
		pedestrian1X := pedestrian1X - 1
		endPedestrian1X := endPedestrian1X - 1
	    elsif pedestrian1Finished = false then
		%moves pedestrian 1 right
		pedestrian1X := pedestrian1X + 1
		endPedestrian1X := endPedestrian1X + 1
	    end if
	    if pedestrian2Finished = true then
		%moves pedestrian 2 left
		pedestrian2X := pedestrian2X - 1
		endPedestrian2X := endPedestrian2X - 1
	    elsif pedestrian2Finished = false then
		%moves pedestrian 2 right
		pedestrian2X := pedestrian2X + 1
		endPedestrian2X := endPedestrian2X + 1
	    end if
	end if
	if pedestrian1X = 432 then
	    %pedestrian 1 finished travelling to the right, so they can start travelling to the left
	    pedestrian1Finished := true
	elsif pedestrian1X = 250 then
	    %pedestrian 1 hasn't finished travelling to the right
	    pedestrian1Finished := false
	elsif pedestrian2X = 220 then
	    %pedestrian 2 finished travelling to the right, so they can start travelling to the left
	    pedestrian2Finished := true
	elsif pedestrian2X = 25 then
	    %pedestrian 2 hasn't finished travelling to the right
	    pedestrian2Finished := false
	end if
	View.Update
	%Traffic Light Changes
	if timeCounter = 500 then
	    %Traffic Light 1
	    drawfilloval (80, 170, 4, 4, 28)         %green light cover
	    drawfilloval (80, 190, 4, 4, 28)         %red light cover
	    drawfilloval (80, 180, 4, 4, 67)         %yellow light
	    %only the yellow light is on
	    yellowLight1On := true
	    greenLight1On := false
	    redLight1On := false
	    %Traffic Light 2
	    drawfilloval (200, 325, 4, 4, 28)         %yellow light cover
	    drawfilloval (200, 315, 4, 4, 28)         %green light cover
	    drawfilloval (200, 335, 4, 4, 12)         %red light
	    %only the red light is on
	    redLight2On := true
	    yellowLight2On := false
	    greenLight2On := false
	    %Traffic Light 3
	    drawfilloval (400, 185, 4, 4, 46)         %green light
	    drawfilloval (400, 195, 4, 4, 28)         %yellow light cover
	    drawfilloval (400, 205, 4, 4, 28)         %red light cover
	    %only the green light is on
	    greenLight3On := true
	    redLight3On := false
	    yellowLight3On := false
	elsif timeCounter = 1000 then
	    %Traffic Light 1
	    drawfilloval (80, 170, 4, 4, 28)         %green light cover
	    drawfilloval (80, 180, 4, 4, 28)         %yellow light cover
	    drawfilloval (80, 190, 4, 4, 12)         %red light
	    %only the red light is on
	    redLight1On := true
	    greenLight1On := false
	    yellowLight1On := false
	    %Traffic Light 2
	    drawfilloval (200, 325, 4, 4, 28)         %yellow light cover
	    drawfilloval (200, 335, 4, 4, 28)         %red light cover
	    drawfilloval (200, 315, 4, 4, 46)         %green light
	    %only the green light is on
	    greenLight2On := true
	    yellowLight2On := false
	    redLight2On := false
	    %Traffic Light 3
	    drawfilloval (400, 185, 4, 4, 28)         %green light cover
	    drawfilloval (400, 195, 4, 4, 67)         %yellow light
	    drawfilloval (400, 205, 4, 4, 28)         %red light cover
	    %only the yellow light is on
	    yellowLight3On := true
	    redLight3On := false
	    greenLight3On := false
	elsif timeCounter = 1500 then
	    %Traffic Light 1
	    drawfilloval (80, 170, 4, 4, 28)         %green light cover
	    drawfilloval (80, 190, 4, 4, 28)         %red light cover
	    drawfilloval (80, 170, 4, 4, 46)         %green light
	    %only the green light is on
	    greenLight1On := true
	    yellowLight1On := false
	    redLight1On := false
	    %Traffic Light 2
	    drawfilloval (200, 315, 4, 4, 28)         %green light cover
	    drawfilloval (200, 335, 4, 4, 28)         %red light cover
	    drawfilloval (200, 325, 4, 4, 67)         %yellow light
	    %only the yellow light is on
	    yellowLight2On := true
	    greenLight2On := false
	    redLight2On := false
	    %Traffic Light 3
	    drawfilloval (400, 185, 4, 4, 28)         %green light
	    drawfilloval (400, 195, 4, 4, 28)         %yellow light cover
	    drawfilloval (400, 205, 4, 4, 12)         %red light
	    %only the red light is on
	    redLight3On := true
	    yellowLight3On := false
	    greenLight3On := false
	end if
	%winning the game
	if carTopY > 329 and startCarMiddleX > 577 or endCarMiddleX > 577 and rightWheelY > 343 then
	    %jack in the box music plays
	    Music.PlayFile ("winGameSound.wav")
	    delay (1)
	    %door closing sound plays
	    Music.PlayFile ("doorClosing.wav")
	    display (1)
	    %exits the loop
	    exit
	    %crashing into grass 1
	elsif carTopY > 43 and endCarMiddleX > 59 and startCarMiddleX < 101 and leftWheelY < 350 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 2
	elsif carTopY > 43 and endCarMiddleX > 139 and startCarMiddleX < 181 and leftWheelY < 214 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 3
	elsif carTopY > 239 and endCarMiddleX > 149 and startCarMiddleX < 251 and leftWheelY < 350 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 4
	elsif carTopY > 43 and endCarMiddleX > 219 and startCarMiddleX < 261 and leftWheelY < 214 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 5
	elsif carTopY > 43 and endCarMiddleX > 299 and startCarMiddleX < 341 and leftWheelY < 350 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 6
	elsif endCarMiddleX > 379 and startCarMiddleX < 421 and leftWheelY < 321 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 7
	elsif carTopY > 49 and endCarMiddleX > 459 and startCarMiddleX < 501 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 8
	elsif carTopY > 49 and endCarMiddleX > 459 and startCarMiddleX < 581 and leftWheelY < 124 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 9
	elsif carTopY > 142 and endCarMiddleX > 539 and leftWheelY < 194 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into grass 10
	elsif carTopY > 214 and endCarMiddleX > 537 and startCarMiddleX < 579 and leftWheelY < 344 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %driving through red light 1
	elsif redLight1On = true and carTopY > 160 and leftWheelY < 203 and endCarMiddleX < 140 then
	    %police siren sound plays
	    Music.PlayFile ("policeSiren.wav")
	    display (3)
	    %exits the loop
	    exit
	    %driving through red light 2
	elsif redLight2On = true and leftWheelY > 349 and endCarMiddleX > 150 and startCarMiddleX < 250 then
	    %police siren sound plays
	    Music.PlayFile ("policeSiren.wav")
	    display (3)
	    %exits the loop
	    exit
	    %driving through red light 3
	elsif redLight3On = true and leftWheelY > 175 and carTopY < 225 and startCarMiddleX > 340 and endCarMiddleX < 460 then
	    %police siren sound plays
	    Music.PlayFile ("policeSiren.wav")
	    display (3)
	    %exits the loop
	    exit
	    %crashing into other cars
	elsif carTopY = leftWheelY2 and endCarMiddleX > 180 and startCarMiddleX < 220 or leftWheelY = carTopY2 and endCarMiddleX > 180 and startCarMiddleX < 220 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	elsif carTopY = leftWheelY2 and endCarMiddleX > 260 and startCarMiddleX < 300 or leftWheelY = carTopY2 and endCarMiddleX > 300 and startCarMiddleX < 220 then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into pedestrian 1
	elsif endCarMiddleX = pedestrian1X and carTopY + 10 >= pedestrianY or startCarMiddleX = endPedestrian1X and carTopY + 10 >= pedestrianY then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	elsif carTopY + 10 >= pedestrianY and pedestrian1X >= startCarMiddleX and endPedestrian1X <= endCarMiddleX then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	    %crashing into pedestrian 2
	elsif endCarMiddleX = pedestrian2X and carTopY + 10 >= pedestrianY or startCarMiddleX = endPedestrian2X and carTopY + 10 >= pedestrianY then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	elsif carTopY + 10 >= pedestrianY and pedestrian2X >= startCarMiddleX and endPedestrian2X <= endCarMiddleX then
	    %car crash sound plays
	    Music.PlayFile ("carCrash.wav")
	    display (2)
	    %exits the loop
	    exit
	end if
	%the time counter increases
	timeCounter := timeCounter + 1
	%number of times the screen updated since the last key press increases
	lastKey := lastKey + 2
	%time counter reset
	if timeCounter >= 1501 then
	    timeCounter := 0
	end if
	delay (3)
    end loop
end playGame

%creates the goodbye/ending screen to show the programmer name and exits the program
procedure goodbye
    %variable declarations
    var endingPic : int := Pic.FileNew ("endingCar.bmp")
    var goodbyeFont : int := Font.New ("MV Boli:15:bold")
    %clears the screen
    title
    %scales the ending picture to the screen size
    endingPic := Pic.Scale (endingPic, 640, 400)
    %draws the ending picture background
    Pic.Draw (endingPic, 0, 0, picMerge)
    %ending text
    Draw.Text ("Thank you for playing my game!", 153, 220, goodbyeFont, white)
    Draw.Text ("Programmed by: Sophia Nguyen", 154, 150, goodbyeFont, white)
    delay (3000)
    %closes the main window and quits the program
    Window.Close (mainWindow)
    GUI.Quit
end goodbye

%Main Program
introduction
loop
    exit when GUI.ProcessEvent
end loop
goodbye
%Music Stops
finished := true
Music.PlayFileStop
%End Program
