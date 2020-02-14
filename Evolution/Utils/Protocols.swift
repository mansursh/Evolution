//
//  ViewController.swift
//  Evolution
//
//  Created by ZAF on 2/28/19.
//  Copyright © 2019 Muzaffar Sharapov. All rights reserved.
//

protocol FeedCellDelegate {
    func handleUsernameTapped(for cell: FeedCell)
    func handleOptionsTapped(for cell: FeedCell)
    func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool)
    func handleCommentTapped(for cell: FeedCell)
    func handleConfigureLikeButton(for cell: FeedCell)
    func handleShowLikes(for cell: FeedCell)
    func configureCommentIndicatorView(for cell: FeedCell)
}

protocol UserProfileHeaderDelegate {
    func handleEditFollowTapped(for header: UserProfileHeader)
    func setUserStats(for header: UserProfileHeader)
    func handleFollowersTapped(for header: UserProfileHeader)
    func handleFollowingTapped(for header: UserProfileHeader)
    
    func handleOptionsTappe(for cell: UserPostCell)
    func handleLikeTappe(for cell: UserPostCell, isDoubleTap: Bool)
    func handleCommentTappe(for cell: UserPostCell)
    func handleConfigureLikeButto(for cell: UserPostCell)
    func handleShowLike(for cell: UserPostCell)
    func configureCommentIndicatorVie(for cell: UserPostCell)
}



//protocol NotificationCellDelegate {
//    func handleFollowTapped(for cell: NotificationCell)
//    func handlePostTapped(for cell: NotificationCell)
//}

protocol CommentInputAccesoryViewDelegate {
    func didSubmit(forComment comment: String)
}

protocol MessageInputAccesoryViewDelegate {
    func handleUploadMessage(message: String)
    func handleSelectImage()
}

protocol FollowCellDelegate {
    func handleFollowTapped(for cell: FollowLikeCell)
}

protocol Printable {
    var description: String { get }
}






