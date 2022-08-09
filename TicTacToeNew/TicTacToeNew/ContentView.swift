//
//  ContentView.swift
//  TicTacToeNew
//
//  Created by Dharmi Patel on 06/04/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
        Home()
                .navigationTitle("Tic Tac Toe Game")
                .preferredColorScheme(.dark)
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var moves : [String] = Array(repeating: "", count: 9)
    
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
    var body: some View{
        
        VStack {
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3),spacing: 15) {
                
                ForEach(0..<9,id: \.self){index in
                    ZStack{
                        
                        Color.blue
                        
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        
    
                        
                        Text (moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .opacity(moves[index] != "" ? 1 : 0)
                            
    
                        
                }
                    
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0)
                    
                    
                    .onTapGesture(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            
                            if moves[index] == "" {
                            moves[index] = isPlaying ? "X" : "0"
                            isPlaying.toggle()
                            }
                            
                        }
                    })
                
                
    }
            }
            
            .padding(15)
}
        .onChange(of: moves, perform: { value in
            
            checkWinner()
        })
        
        .alert(isPresented: $gameOver, content: {
            
            Alert(title: Text("Winner"), message: Text(msg), dismissButton:
                    .destructive(Text("Play Again"), action: {
                        
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            
                            moves.removeAll()
                            moves = Array(repeating: "", count: 9)
                            isPlaying = true
                        }
                    }))
        })

    }
    
    func getWidth()->CGFloat{
        
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 3

    }
    
    func checkWinner (){
        
        if checkMoves(player: "X"){
            
            msg = "Player X Won !!!"
            gameOver.toggle()
            
        }
        else if checkMoves(player: "0"){
            
            msg = "Player 0 Won !!!"
            gameOver.toggle()
            
        }
        
        else{
            
            let status = moves.contains { (value) -> Bool in
                
                return value == ""
                
            
            }
            if !status{
                
                msg = " Game Over Tied !!!"
                gameOver.toggle()
            }
        }
    }
    
    func checkMoves(player: String)->Bool{
        
 
    for i in stride(from: 0, to: 9, by: 3){
        
        if moves[i] == player && moves[i + 1] == player && moves[i + 2] ==
            player{
            
            return true
        }
    }
        
        for i in 0...2{
               
               if moves[i] == player && moves[i + 3] == player && moves[i + 6] ==
                   player{
                   
                   return true
               }
           }
               
if moves[0] == player && moves[4] == player && moves[8] == player{
    
    return true
        }
        if moves[2] == player && moves[4] == player && moves[6] == player{
            
            return true
                }
    return false
    
}

}

