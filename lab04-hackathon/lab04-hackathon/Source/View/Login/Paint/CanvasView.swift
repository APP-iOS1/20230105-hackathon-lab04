//
//  CanvasView.swift
//  lab04-hackathon
//
//  Created by 박성민 on 2023/01/05.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @Environment(\.undoManager) private var undoManager
    @State var canvas = PKCanvasView()
    @State var drawingImage: [Data] = []
    @State var toggle: Bool = false
    @State private var showingAlert = false

    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action : {
                        SaveImage()
                    }, label: {
                        Image("down")
                            .resizable()
                            .frame(width: 44, height: 44)
                        
                    })
                    .padding(.leading,20)
                    Spacer()
                    Button(action: {
                        showingAlert = true
                    }, label: {
                        Image("new")
                            .resizable()
                            .frame(width: 44, height: 44)
                    })
                    .alert("새로 그리시겠습니까?", isPresented: $showingAlert) {
                        Button("취소", role: .cancel) { }
                        Button("확인") {
                            canvas.drawing = PKDrawing()
                        }
                    }
                    
                    .padding(.trailing,20)
                    
                }
                Spacer()
                Divider()
                DrawingView(toggle: $toggle, canvas: $canvas)
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.width)
                Divider()
                HStack {
                    Button(action: {
                        undoManager?.undo()
                        
                    }, label: {
                        Image("reload2")
                            .resizable()
                            .frame(width: 44, height: 44)
                    })
                    .padding(.trailing,40)
                    Button(action: {
                        undoManager?.redo()
                        
                    }, label: {
                        Image("reload")
                            .resizable()
                            .frame(width: 44, height: 44)
                    })
                    Button(action: {
                        toggle.toggle()
                    }, label: {
                        Image(systemName: "pencil.tip.crop.circle")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color.black)
                    })
                    .padding(.leading,40)

                    
                }
                Spacer()
            }
            
        }
    }
    
    func SaveImage() {
        
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}

struct DrawingView : UIViewRepresentable {
    @Binding var toggle: Bool
    @Binding var canvas: PKCanvasView
    let picker = PKToolPicker.init()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        picker.addObserver(canvas)
        picker.setVisible(toggle, forFirstResponder: uiView)
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
    }

}
