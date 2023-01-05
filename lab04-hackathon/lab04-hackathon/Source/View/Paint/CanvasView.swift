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
    @State var toggle: Bool = true
    @State private var showingAlert = false

    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack(spacing: 10) {
                    Button(action: {
                        undoManager?.undo()
                        
                    }, label: {
                        Image(systemName: "arrow.uturn.left")
                    })
                    Button(action: {
                        undoManager?.redo()

                    }, label: {
                        Image(systemName: "arrow.uturn.right")
                    })
                }
                Divider()
                DrawingView(toggle: $toggle, canvas: $canvas)
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.width)
                Divider()
                Button(action: {toggle.toggle()}, label: {Text("그리기도구")})
                
                
            }
            .navigationTitle("Drawing")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action : {
                SaveImage()
            }, label: {
                Image(systemName: "menubar.arrow.down.rectangle")
            }),trailing: HStack(spacing: 15){
                Button("새로그리기") {
                    showingAlert = true
                }
                .alert("새로 그리시겠습니까?", isPresented: $showingAlert) {
                    Button("취소", role: .cancel) { }
                    Button("확인") {
                        canvas.drawing = PKDrawing()
                    }
                }
            })
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

