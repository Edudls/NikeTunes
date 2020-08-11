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
        XCTAssertEqual(URL(string: AlbumConstants.albumsUrl.rawValue), URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/non-explicit.json"))
        XCTAssertEqual(URL(string: AlbumConstants.explicitUrl.rawValue), URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"))
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
        let vm = AlbumListViewModel()
        vc.viewModel = vm
        //set artwork url to nil so we don't actually attempt to retrieve an image from an API, which exceeds the scope of this test
        vc.viewModel?.albums = [Album(artistName: "dude", releaseDate: "whenever", name: "songs", copyright: "owned", artworkUrl: nil, genres: [Genre(name: "album"), Genre(name: "music")], storeUrl: "music.com")]
        vc.cellIndex = 0 //redundancy
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.title, "songs")
        XCTAssertEqual(vc.artist.text, "dude")
        XCTAssertEqual(vc.releaseDate.text, "Released whenever")
        XCTAssertEqual(vc.name.text, "songs")
        XCTAssertEqual(vc.copyright.text, "owned")
        XCTAssertEqual(vc.genres.text, "album, music")
        XCTAssertEqual(vc.storeLink.titleLabel?.text, "Open in Apple Music")
        vc.viewModel = nil
    }
    
    func testAlbumListDecodeJsonData() {
        let vm = AlbumListViewModel()
        guard let path = Bundle(for: NikeTunesTests.self).path(forResource: "MockJson", ofType: "json") else { return }
        var jsonData = Data()
        do {
            jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        } catch {
            XCTFail()
        }
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
