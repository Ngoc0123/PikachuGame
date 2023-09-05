//
//  ContentView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    @Binding var player:Player
    @Environment (\.managedObjectContext) var moc
    
    @State var language = UserDefaults.standard.string(forKey: "Language")
    
    
    @State var shuffle = 0
    @State var score = 0
    
    
    var columns:Int
    var rows:Int

    @State var isHighscore = false
    @State var isGaming = true
    @State var isPause = false
    @State var isWinning = 0
    @State var isAvailable = false
    @State var showAchievement = false
    @State var isOutOfShuffle = false
    
    
    @State var pokemonGrid: [Pokemon]
    @State var selectedPokeGridIndex1: Int = 0
    @State var selectedPokeGridIndex2: Int = 0
    
    @State var i: Int
    
    @State var remainPokemon: [Pokemon]
    @State var remainIndex: [Int]
    
    @State var selecting = 0
    
    
    
    @StateObject private var tvm = TimerViewModel()
    @State var timerStop = false
    

    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        if isGaming {
            ZStack{
                Image("Background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width+10,height: UIScreen.main.bounds.height+30)
                
                VStack(spacing: UIDevice.current.userInterfaceIdiom == .pad ? 120 : 10){
                    HStack{
                        TimerBar(diff: tvm.diff)

                    }
                    .padding(.top,UIDevice.current.userInterfaceIdiom == .pad ? 90 : 50)
                    
                
                    HStack(alignment: .center,spacing: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50){
                        VStack(spacing: UIDevice.current.userInterfaceIdiom == .pad ? 80 : 20){
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                timerStop.toggle()
                                tvm.stopTimer()
                                withAnimation {
                                    isPause = true
                                }
                                
                                print("stop")
                                
                            } label: {
                                Image(systemName: "pause.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.black)
                                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
                            }
                            
                            
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                
                                if shuffle > 0 {
                                    self.shuffleRemaining()
                                    shuffle -= 1
                                }else{
                                    withAnimation {
                                        isOutOfShuffle = true
                                    }
                                }
                                
                                
                            } label: {
                                Image(systemName: "arrow.counterclockwise.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.black)
                                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
                            }

                        }


        
                        GridView(pokemonGrid: pokemonGrid, selectedPokeGridIndex1: $selectedPokeGridIndex1, selectedPokeGridIndex2: $selectedPokeGridIndex2, selecting: $selecting, columns: columns, rows: rows)
                
                        VStack{
                            Text(language == "english" ? "SCORE" : "ĐIỂM SỐ")
                                .padding(.top,50)
                            Text("\(score)")
                            
                        }
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 120 : 80)
                    
                    }
                    
                    Spacer()

                }
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    audioPlayer?.stop()
                    playSound(sound: "gamebackground", type: "mp3")
                    remainPokemon = pokemonGrid
                    
                    for index in pokemonGrid.indices {
                        print("\(index)")
                        remainIndex.append(index)
                    }
                    
                    
                    shuffleRemaining()
                    
                    switch player.gameMode{
                    case 1:
                        tvm.start(minutes: 5)
                        shuffle = 5
                    case 2:
                        tvm.start(minutes: 4)
                        shuffle = 3
                    case 3:
                        tvm.start(minutes: 3)
                        shuffle = 1
                    default:
                        tvm.start(minutes: 5)
                        shuffle = 5
                    }
                    
                }
                .onChange(of: selecting) { newValue in
                    if newValue == 2 {
                        if matchingBlocks(index1: selectedPokeGridIndex1, index2: selectedPokeGridIndex2) {
                            playSound2(sound: "match", type: "mp3")
                            removePokemonIndex(index: selectedPokeGridIndex1)
                            removePokemonIndex(index: selectedPokeGridIndex2)
                            score += 50

                            if checkRemaining() {
                                
                            }else{
                                if checkAvailable(){
                                    shuffleRemaining()
                                }
                            }
                            
                            
                            
                        }else{
                            playSound2(sound: "error", type: "mp3")
                        }
                        selecting = 0
                        selectedPokeGridIndex1 = -1
                        selectedPokeGridIndex2 = -1
                    }
                }
                .onReceive(timer){ _ in
                    tvm.updateCountDown()
                    
                    if (tvm.isAlert){
                        withAnimation {
                            isWinning = -1
                        }
                        playSound(sound: "gameover", type: "mp3")
                    }
                }
                
                if isPause {
                    ZStack{
                        Color.black
                            .opacity(0.5)
                        ZStack{
                            Image("Box")
                                .resizable()
                                .frame(width: 600,height: 400)
                            VStack{
                                Text(language == "english" ? "Pause!!" : "Tạm dừng!!")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Button {
                                    AudioServicesPlaySystemSound(1104)
                                    timerStop.toggle()
                                    tvm.continueTimer()
                                    withAnimation {
                                        isPause = false
                                    }
                                    
                                } label: {
                                    
                                    CustomButton(text: language == "english" ? "Continue" : "Tiếp tục", width: 200, height: 40)
                                }
                                Button {
                                    AudioServicesPlaySystemSound(1104)
                                    withAnimation {
                                        isGaming = false
                                    }
                                    
                                } label: {
                                    CustomButton(text: language == "english" ? "Back to Menu" : "Quay về Menu", width: 200, height: 40)
                                }

                            }
                        }
                        
                        
                    }
                    .transition(.opacity)
                }
                
                if isWinning == 1{
                    ZStack{
                        Color.black
                            .opacity(0.5)
                        ZStack{
                            Image("Box")
                                .resizable()
                                .frame(width: 600,height: 400)
                            VStack(spacing: 10){
                                Text(language == "english" ? "🥳Victory!!!🥳" : "🥳Chiến Thắng!!!🥳")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                if isHighscore{
                                    HStack{
                                        Image("crown")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80)
                                        Text(language == "english" ? "New Highscore" : "Điểm cao mới")
                                            .font(.largeTitle)
                                        Image("crown")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80)
                                            
                                    }
                                    .frame(maxHeight: 100)
                                    
                                    Text("\(score)")
                                        .font(.largeTitle)
                                    
                                }else{
                                    VStack{
                                        Text(language == "english" ? "Score" : "Điểm số")
                                            .font(.largeTitle)
                                        Text("\(score)")
                                            .font(.largeTitle)
                                }
                                
                                    
                                    
                                }
                                Button {
                                    AudioServicesPlaySystemSound(1104)
                                    if player.progression < columns/4 {
                                        player.progression = columns/4
                                    }
                                    
                                    player.won += 1
                                    player.matches += 1
                                    withAnimation {
                                        isGaming = false
                                    }
                                    DataController().savePlayer(player: player, context: moc)
                                } label: {
                                    CustomButton(text: "Back to Meunu", width: 200, height: 30)
                                }
                            }
                            
                        }
                        
                        
                    }
                    .transition(.opacity)
                }else if isWinning == -1{
                    ZStack{
                        Color.black
                            .opacity(0.5)
                        ZStack{
                            Image("Box")
                                .resizable()
                                .frame(width: 600,height: 400)
                            VStack(spacing: 10){
                                Text(language == "english" ? "😭Game Over😭" : "😭Thất Bại😭")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                HStack{
                                    Text(language == "english" ? "Score: " : "Điểm số: ")
                                    Text("\(score)")
                                }
                                Button {
                                    AudioServicesPlaySystemSound(1104)
                                    player.matches += 1
                                    DataController().savePlayer(player: player, context: moc)
                                    withAnimation {
                                        isGaming = false
                                    }
                                } label: {
                                    CustomButton(text: "Back to Meunu", width: 200, height: 30)
                                }
                            }
                            
                        }
                        
                        
                    }
                }
                
                if showAchievement{
                    PopupAchievementView(showAchievement: $showAchievement, id: columns/4)
                        
                }
                    
                if isAvailable {
                    AvailableView()
                        .onAppear(perform: {
                             DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                 withAnimation {
                                     isAvailable = false
                                 }

                             }
                        })
                }
                
                if isOutOfShuffle {
                    OutOfShuffleView()
                        .onAppear(perform: {
                             DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                 withAnimation {
                                     isOutOfShuffle = false
                                 }

                             }
                        })
                        .onTapGesture {
                            withAnimation {
                                isOutOfShuffle = false
                            }
                        }
                }
                
                
            }
            
            .ignoresSafeArea()

            
        }else{
            MenuView(player: $player,loggedIn: true)
        }
        
    }
    
    

// MARK: Game Logic

    func checkRemaining() -> Bool{
        if remainIndex.count == 0{
            tvm.stopTimer()
            score += Int(tvm.remainingTime/100) * player.gameMode
            print("\(tvm.remainingTime/100)")
            print("\(player.gameMode)")
            
            if score > player.highscore {
                player.highscore = score
                print("new highscore")
                isHighscore = true
            }
            
            if player.progression < columns/4 {
                withAnimation {
                    showAchievement = true
                }
                
            }
            DataController().addResult(name: player.name, score: Int64(score), context: moc)
            withAnimation {
                isWinning = 1
            }
            playSound(sound: "victory", type: "mp3")
            return true
            
        }
        return false
    }
    
    func shuffleRemaining(){
        remainIndex.shuffle()
        
        for index in remainIndex.indices{
            print("\(index)")
            pokemonGrid[remainIndex[index]] = remainPokemon[index]
        }
        
        if checkAvailable() {
            shuffleRemaining()
        }
        return
    }
    
    func checkAvailable() -> Bool{
        
        for i in remainPokemon.indices {
            var j = i+1
            
            while (j < remainPokemon.count  && remainPokemon[i].id == remainPokemon[j].id){
                
                if matchingBlocks(index1: remainIndex[i], index2: remainIndex[j]) {
                    return false
                }
                j += 1
            }
            
        }
        withAnimation {
            isAvailable = true
        }
        return true
    }
    
    func removePokemonIndex(index: Int){
        pokemonGrid[index] = Pokemon(id: -1, name: "")

        self.i = remainIndex.firstIndex(of: index)!
        remainIndex.remove(at: i)
        remainPokemon.remove(at: i)
        
    }
    
    func checkCase(index1: Int, index2: Int) -> Int {
        var res = 0
        
        //check same row
        if getYCoordinate(index: index1) ==  getYCoordinate(index: index2){
            res = 1
            
        //check same column
        }else if getXCoordinate(index: index1) == getXCoordinate(index: index2){
            res = 2
            
        //check rectangle case
        }else{
            res = 3
        }
        
        return res
    }
    
    func checkRow(x1: Int, x2: Int, y: Int) -> Bool{
        if x1 == x2 {
            return true
        }

        for index in x1+1..<x2{
            if pokemonGrid[index+y*columns].id != -1{
                return false
            }
        }
        
        return true
    }
    
    func checkCol(y1: Int, y2: Int, x:Int) -> Bool{
        if y1 == y2 {
            return true
        }

        for index in y1+1..<y2{
            if(index == -1 ){
                continue
            }
            
            if(index == rows){
                continue
            }
            
            if pokemonGrid[x+index*columns].id != -1{
                return false
            }
        }
        
        return true
    }
    
    func getXCoordinate(index: Int) -> Int{
        return index%columns
    }
    
    func getYCoordinate(index: Int) -> Int{
        return index/columns
    }
    
    func checkHRectangle(index1: Int, index2: Int) -> Bool{

        var u,d:Int

        if getYCoordinate(index: index1) > getYCoordinate(index: index2){
            u = index2
            d = index1
        }else{
            d = index2
            u = index1
            
        }
        
        
        for col in getXCoordinate(index: index1)+1..<getXCoordinate(index: index2){
            if checkCol(y1: getYCoordinate(index: u) - 1, y2: getYCoordinate(index: d) + 1, x: col){
                if checkRow(x1: getXCoordinate(index: index1), x2: col+1, y: getYCoordinate(index: index1)) &&
                    checkRow(x1: col-1, x2: getXCoordinate(index: index2), y: getYCoordinate(index: index2))
                {
                    return true
                }
            }
        }
        return false
    }
    
    func checkVRectangle(index1: Int, index2: Int) -> Bool{

        var l,r:Int

        if getXCoordinate(index: index1) > getXCoordinate(index: index2){
            l = index2
            r = index1
        }else{
            r = index2
            l = index1
            
        }
        
        
        for row in getYCoordinate(index: index1)+1..<getYCoordinate(index: index2){
            if checkRow(x1: getXCoordinate(index: l) - 1, x2: getXCoordinate(index: r) + 1, y: row){
                if checkCol(y1: getYCoordinate(index: index1), y2: row+1, x: getXCoordinate(index: index1)) &&
                    checkCol(y1: row-1, y2: getYCoordinate(index: index2), x: getXCoordinate(index: index2))
                {
                    return true
                }
            }
        }
        return false
    }
    
    func checkMoreCols(index1: Int, index2: Int,direction: Bool)->Bool{
        var u,d:Int

        if getYCoordinate(index: index1) > getYCoordinate(index: index2){
            u = index2
            d = index1
        }else{
            d = index2
            u = index1
            
        }
        
        
        for col in getXCoordinate(index: index2)...columns{
            print(col)
            if  checkRow(x1: getXCoordinate(index: index1), x2:col + ((getXCoordinate(index: index2) - getXCoordinate(index: index1) == 1) ? 1 : 0), y: getYCoordinate(index: index1)) &&
                    (col == columns ? true : ((col == getXCoordinate(index: index2) && getXCoordinate(index: index1) != getXCoordinate(index: index2)) ? true : checkCol(y1: getYCoordinate(index: u)-1, y2: getYCoordinate(index: d)+1, x: col))) &&
                    (col == getXCoordinate(index: index2) ? true : checkRow(x1: getXCoordinate(index: index2), x2: col, y: getYCoordinate(index: index2))){
                return true
            }
        }
        
        for col in -1...getXCoordinate(index: index1){
            print(col)
            if  (col == getXCoordinate(index: index1) ? true : checkRow(x1: col, x2:getXCoordinate(index: index1) , y: getYCoordinate(index: index1))) &&
                    (col == -1 ? true : checkCol(y1: getYCoordinate(index: u)-1, y2: getYCoordinate(index: d)+1, x: col)) &&
                    checkRow(x1: col + ((getXCoordinate(index: index2) - getXCoordinate(index: index1) == 1) ? 0 : 1), x2: getXCoordinate(index: index2), y: getYCoordinate(index: index2)){
                return true
            }


        }
        
        
        
        return false
    }
    
    func checkMoreRows(index1: Int, index2: Int,direction: Bool)->Bool{
        
        var l,r:Int

        if getXCoordinate(index: index1) > getXCoordinate(index: index2){
            l = index2
            r = index1
        }else{
            r = index2
            l = index1
            
        }
        
        for row in getYCoordinate(index: index2)...rows{
            print(row)
            if  checkCol(y1: getYCoordinate(index: index1), y2: row + ((getYCoordinate(index: index2) - getYCoordinate(index: index1) == 1) ? 1 : 0), x: getXCoordinate(index: index1)) &&
                    (row == rows ? true : checkRow(x1: getXCoordinate(index: l)-1, x2: getXCoordinate(index: r) + (((row == getYCoordinate(index: index2) && getYCoordinate(index: index1) != getYCoordinate(index: index2))) ? 1 : 0), y: row)) &&
                    (row == getYCoordinate(index: index2) ? true : checkCol(y1: getYCoordinate(index: index2), y2: row, x: getXCoordinate(index: index2))){
                return true
            }
        }
        
        for row in -1...getYCoordinate(index: index1){
            print(row)
            if  (row == getYCoordinate(index: index1) ? true : checkCol(y1: row, y2: getYCoordinate(index: index1), x: getXCoordinate(index: index1))) &&
                (row == -1 ? true : checkRow(x1: getXCoordinate(index: l)-1, x2: getXCoordinate(index: r)+1, y: row)) &&
                checkCol(y1: row + ((getYCoordinate(index: index2) - getYCoordinate(index: index1) == 1) ? -1 : 0), y2: getYCoordinate(index: index2), x: getXCoordinate(index: index2)){
                return true
            }
        }
        
  
        return false
    }
    
    
    
    func matchingBlocks(index1: Int, index2: Int) -> Bool{
        if pokemonGrid[index1].id != pokemonGrid[index2].id{
            return false
        }
        
        let x1 = getXCoordinate(index: index1),y1 = getYCoordinate(index: index1)
        
        let x2 = getXCoordinate(index: index2),y2 = getYCoordinate(index: index2)
        
        var l,r,d,u:Int
        
        if x1 > x2 {
            r = index1
            l = index2
        }else{
            l = index1
            r = index2
        }
        
        if y1 > y2 {
            d = index1
            u = index2
        }else{
            u = index1
            d = index2
        }
        
        let check = checkCase(index1: index1, index2: index2)
        //var match = false
        
        switch check{
            
        case 1:
            print("check row")
            if checkRow(x1: getXCoordinate(index: l), x2: getXCoordinate(index: r), y: y1) {
                return true
            }
            
            print("check more rows")
            if checkMoreRows(index1: u, index2: d, direction: true){
                return true
            }
            
        case 2:
            print("check col")
            if checkCol(y1: getYCoordinate(index: u), y2: getYCoordinate(index: d), x: x1) {
                return true
            }
            print("check more cols")
            if checkMoreCols(index1: l, index2: r, direction: true){
                return true
            }
        case 3:
            print("check Hrec")
            if checkHRectangle(index1: l, index2: r) {
                
                return true
            }
            print("check Vrec")
            if checkVRectangle(index1: u, index2: d) {
                return true
            }
            print("check more cols")
            if checkMoreCols(index1: l, index2: r, direction: true) {
                return true
            }
            print("check more rows")
            if checkMoreRows(index1: u, index2: d, direction: true){
                return true
            }
            
            
        default: break
            
        }
        
        return false
    }
    
    
}


