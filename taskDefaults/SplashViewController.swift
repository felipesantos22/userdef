//
//  SplashViewController.swift
//  taskDefaults
//
//  Created by Felipe Santos on 29/04/25.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    // View que irá exibir a animação Lottie
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            let viewController = ViewController()
            let uINavigationController = UINavigationController(rootViewController: viewController)
            uINavigationController.modalPresentationStyle = .fullScreen
            self.present(uINavigationController, animated: true, completion: nil)
        }
        
        super.viewDidLoad()
        
        // Carrega a animação chamada "list" (deve estar incluída no projeto)
        let animation = LottieAnimation.named("list")
        
        // Cria uma LottieAnimationView com a animação carregada
        animationView = LottieAnimationView(animation: animation)
        
        // Garante que a animationView foi criada com sucesso
        guard let animationView = animationView else { return }
        
        // Define o tamanho da animationView para ocupar toda a tela
        animationView.frame = view.bounds
        
        // Define o modo de conteúdo para ajustar a animação proporcionalmente
        animationView.contentMode = .scaleAspectFit
        
        // Faz a animação repetir em loop
        animationView.loopMode = .loop
        
        // Define a velocidade da animação (0.5 = metade da velocidade normal)
        animationView.animationSpeed = 0.5
        
        // Adiciona a animationView como subview da view principal
        view.addSubview(animationView)
        
        // Inicia a animação
        animationView.play()
    }
    
}
