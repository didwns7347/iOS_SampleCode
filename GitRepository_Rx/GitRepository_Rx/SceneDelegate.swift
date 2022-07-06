//
//  SceneDelegate.swift
//  GitRepository_Rx
//
//  Created by yangjs on 2022/06/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = UINavigationController(rootViewController: RepositoryViewCotroller()) 
        window?.tintColor = .label
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        /*
         21년 8월 현재 재직중인 회사에 웹개발자로 입사를 하게되었고 당시 회사에서 iOS개발자가 부족해 저에게 포지션을 변경해 볼것을 제안해 주셔서 iOS개발을 처음 접하게 되었습니다.
         처음 도전해 보는 분야여서 부족한 점들이 많았지만 빠른 시간안에 많은 것들을 배울 수 있었습니다. 입사후 얼마후 프로젝트를 진행해 나가면서 Objective c에 대한 기초적인 문법을 익힐 수 있었고,
         사내에서 관리하는 앱들의 엔터프라이즈 배포, 애플 스토어 배포를 진행 하면서 애플에서 제공하는 인증서/프로비저닝 등 애플의 인증서에 대한 기본적인 이해도를 높일 수 있었습니다.
         
         대학교 졸업이후 2021년 2월부터 2021년 8월까지 6 개월의 기간 동안 웹서비스 개발에 대한 공부를 하고 싶어 비트교육센터라는 곳에서 웹 개발자 교육과정을 이수한 경험이 있습니다. 해당 교육과정은 크게 2부분으로 나누어지는데 3개월 동안은 mysql, mongodb, javascrpit, spring framework 등 웹 서비스의 front-end, back-end에서 많이 사용되고 있는 기술 들을 학습하고 실습하면서 웹 서비스에 대한 전반적인 지식들을 배우게 되고 3개월 동안은 2인 1조가 되어 기업과 연계하여 웹 서비스를 직접 만들어 보는 프로젝트를 진행하게 되었습니다. 저가 진행한 프로젝트는 blinkist.com이라는 외국 오디오 북 서비스에 있는 모든 기능을 저희가 직접 웹 어플리케이션으로 구현해 aws에 배포까지 하는 것을 목표로 프로젝트를 진행하였고 프로젝트를 진행하였고 반응형 웹으로 페이지를 제작하여 디바이스에 제약 없이 서비스를 이용 가능하게 하였습니다.저는 도서추천, 도서검색, 회원 관리, 메인 페이지를 구현하는 역활을 담당하였습니다. 해당 경험을 통해 스프링 프레임워크, 마이바티스, 스프링 시큐리티, 등 다양한 프레임 워크를 사용해 볼 수 있는 경험을 하였고, 서버 클라이언트가 어떤 방식으로 동작하는지 구체적으로 알 수 있었던 경험이었습니다.

         */
    }


}

