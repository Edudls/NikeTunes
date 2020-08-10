//
//  NikeTunesTests.swift
//  NikeTunesTests
//
//  Created by DMonaghan on 8/8/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import XCTest
@testable import NikeTunes

class NikeTunesTests: XCTestCase {
    
    func testAlbumConstants() {
        XCTAssertEqual(AlbumConstants.albumsUrl, URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/non-explicit.json"))
        XCTAssertEqual(AlbumConstants.explicitUrl, URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"))
    }
    
    func testAlbumListShowExplicit() {
        let vm = AlbumListViewModel()
        vm.shouldShowExplicit = true
        XCTAssertEqual(vm.leftButtonText, "Hide Explicit")
        XCTAssertEqual(vm.albumsUrl, URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"))
        vm.shouldShowExplicit = false
        XCTAssertEqual(vm.leftButtonText, "Show Explicit")
        XCTAssertEqual(vm.albumsUrl, URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/non-explicit.json"))
    }
    
    func testAlbumDetailBuildUI() {
        let vc = AlbumDetailViewController()
        let genres = [Genre(name: "album"), Genre(name: "music")]
        //set artwork url to nil so we don't actually attempt to retrieve an image from an API, which exceeds the scope of this test
        let album = Album(artistName: "dude", releaseDate: "whenever", name: "songs", copyright: "owned", artworkUrl: nil, genres: genres, storeUrl: "music.com")
        vc.viewModel.album = album
        vc.buildUI()
        XCTAssertEqual(vc.title, "songs")
        XCTAssertEqual(vc.artist.text, "dude")
        XCTAssertEqual(vc.releaseDate.text, "Released whenever")
        XCTAssertEqual(vc.name.text, "songs")
        XCTAssertEqual(vc.copyright.text, "owned")
        XCTAssertEqual(vc.genres.text, "album, music")
        XCTAssertEqual(vc.storeLink.titleLabel?.text, "Open in Apple Music")
    }
    
    func testAlbumListDecodeJsonData() {
        let vm = AlbumListViewModel()
        let jsonData: Data = """
{"feed":{"title":"Top Albums","id":"https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/2/explicit.json","author":{"name":"iTunes Store","uri":"http://wwww.apple.com/us/itunes/"},"links":[{"self":"https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/2/explicit.json"},{"alternate":"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?genreId=34\\u0026popId=82\\u0026app=music"}],"copyright":"Copyright © 2018 Apple Inc. All rights reserved.","country":"us","icon":"http://itunes.apple.com/favicon.ico","updated":"2020-08-09T02:05:07.000-07:00","results":[{"artistName":"Rod Wave","id":"1526631313","releaseDate":"2020-08-07","name":"Pray 4 Love (Deluxe)","kind":"album","artistId":"1140623439","contentAdvisoryRating":"Explicit","artistUrl":"https://music.apple.com/us/artist/rod-wave/1140623439?app=music","artworkUrl100":"https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/fc/b4/b2/fcb4b20a-8d6a-f20a-c587-90b14799a00e/808391092006-cover.jpg/200x200bb.png","genres":[{"genreId":"18","name":"Hip-Hop/Rap","url":"https://itunes.apple.com/us/genre/id18"},{"genreId":"34","name":"Music","url":"https://itunes.apple.com/us/genre/id34"}],"url":"https://music.apple.com/us/album/pray-4-love-deluxe/1526631313?app=music"},{"artistName":"Pop Smoke","id":"1521889004","releaseDate":"2020-07-03","name":"Shoot for the Stars Aim for the Moon","kind":"album","copyright":"Victor Victor Worldwide; ℗ 2020 Republic Records, a division of UMG Recordings, Inc. \\u0026 Victor Victor Worldwide","artistId":"1450601383","contentAdvisoryRating":"Explicit","artistUrl":"https://music.apple.com/us/artist/pop-smoke/1450601383?app=music","artworkUrl100":"https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/17/6d/e0/176de0c9-42a6-8741-9d22-6aae00094e1d/20UMGIM55833.rgb.jpg/200x200bb.png","genres":[{"genreId":"18","name":"Hip-Hop/Rap","url":"https://itunes.apple.com/us/genre/id18"},{"genreId":"34","name":"Music","url":"https://itunes.apple.com/us/genre/id34"}],"url":"https://music.apple.com/us/album/shoot-for-the-stars-aim-for-the-moon/1521889004?app=music"}]}}
""".data(using: .utf8) ?? Data()
        vm.decodeJsonToAlbums(data: jsonData)
        XCTAssertEqual(vm.albums[1].artistName, "Pop Smoke")
        XCTAssertEqual(vm.albums[1].releaseDate, "2020-07-03")
        XCTAssertEqual(vm.albums[1].name, "Shoot for the Stars Aim for the Moon")
        XCTAssertEqual(vm.albums[1].copyright, "Victor Victor Worldwide; ℗ 2020 Republic Records, a division of UMG Recordings, Inc. & Victor Victor Worldwide")
        XCTAssertEqual(vm.albums[1].artworkUrl, "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/17/6d/e0/176de0c9-42a6-8741-9d22-6aae00094e1d/20UMGIM55833.rgb.jpg/200x200bb.png")
        XCTAssertEqual(vm.albums[1].genres?[0].name, "Hip-Hop/Rap")
        XCTAssertEqual(vm.albums[1].storeUrl, "https://music.apple.com/us/album/shoot-for-the-stars-aim-for-the-moon/1521889004?app=music")
    }
}
