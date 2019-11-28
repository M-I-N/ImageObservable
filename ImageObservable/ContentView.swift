//
//  ContentView.swift
//  ImageObservable
//
//  Created by Mufakkharul Islam Nayem on 11/28/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import SwiftUI

struct ImagePicker: View {

    @State private var isShowingImagePicker = false
    @State private var isShowingDetailView = false
    @ObservedObject var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.isShowingImagePicker.toggle()
                }) {
                    Image(uiImage: viewModel.image)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .overlay(Circle() .stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 3, x: 0, y: 3)
                        .frame(width: 60.0, height: 70.0)

                        .sheet(isPresented: $isShowingImagePicker, content: {
                            ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$viewModel.image)
                        })
                }

                NavigationLink(destination: DetailView(userViewModel: viewModel), isActive: $isShowingDetailView) {
                    Text("Detail")
                }

            }
            .navigationBarTitle(Text("Home"))
        }
    }

    struct ImagePickerView: UIViewControllerRepresentable {

        @Binding var isPresented: Bool
        @Binding var selectedImage: UIImage

        func makeUIViewController(context:
            UIViewControllerRepresentableContext<ImagePickerView>) ->
            UIViewController {
                let controller = UIImagePickerController()
                controller.delegate = context.coordinator
                return controller
        }

        func makeCoordinator() -> ImagePickerView.Coordinator {
            return Coordinator(parent: self)
        }

        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

            let parent: ImagePickerView
            init(parent: ImagePickerView) {
                self.parent = parent
            }

            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                    print(selectedImageFromPicker)
                    self.parent.selectedImage = selectedImageFromPicker
                }

                self.parent.isPresented = false
            }
        }


        func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {

        }
    }
}

struct DetailView: View {
    var userViewModel: UserViewModel
    var body: some View {
        Image(uiImage: userViewModel.image)
        .renderingMode(.original)
        .resizable()
        .scaledToFill()
        .clipShape(Circle())
        .overlay(Circle() .stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 3, x: 0, y: 3)
        .frame(width: 60.0, height: 70.0)
            .navigationBarTitle(Text("Detail"), displayMode: .inline)
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}
