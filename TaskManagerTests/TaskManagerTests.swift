//
//  TaskManagerTests.swift
//  TaskManagerTests
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import XCTest
@testable import TaskManager

class TaskManagerTests: XCTestCase {
    
    var sb: UIStoryboard?
    var mainView: TMMainViewController?
    var mainPresenter: TMMainPresenterProtocol?
    var mainWireframe: TMMainWireframeProtocol?
    var basicTasksCount: Int?
    var detailView: TMTaskDetailViewController?
    
    var newTask: Task?
    
    override func setUp() {
        super.setUp()
        
        sb = UIStoryboard(name: "Main", bundle: nil)
        mainView = sb?.instantiateViewController(withIdentifier: "MainView") as? TMMainViewController
        mainView?.loadViewIfNeeded()
        
        mainPresenter = mainView?.presenter
        
        mainPresenter?.getData()
        
        mainWireframe = mainPresenter?.wireframe
        basicTasksCount = mainView?.presenter?.tasksCount
        
    }
    
    override func tearDown() {
        
        sb = nil
        mainView = nil
        mainPresenter = nil
        mainWireframe = nil
        basicTasksCount = nil
        
        detailView = nil
        
        if let _ = newTask {
            TMPersistentService.context.delete(newTask!)
            TMPersistentService.saveContext()
            newTask = nil
        }
        
        super.tearDown()
    }
    
    func testCreationOfATask() {
        
        let newTaskTitle = "TestTask"
        
        detailView = sb?.instantiateViewController(withIdentifier: "DetailView") as? TMTaskDetailViewController
        detailView?.loadViewIfNeeded()
        
        mainPresenter?.setupTaskDetailViewController(detailView: detailView!)
        
        detailView?.presenter?.didChangeTitle(text: newTaskTitle)
        
        // Save new Task and back on
        detailView?.presenter?.doneButtonTapped()
        
        newTask = detailView?.presenter?.task
        
        XCTAssert(newTask != nil, "Didn't created new task on detail view")
        XCTAssert(newTask?.title == newTaskTitle, "New task title is incorrect: \(String(describing: newTask?.title))")
        
        mainView?.presenter?.getData()
        
        let implementedCount = mainView?.presenter?.tasksCount
        
        XCTAssert(implementedCount! == basicTasksCount! + 1, "basic count: \(String(describing: basicTasksCount)) is not implemented! new count = \(String(describing: implementedCount))")
        
    }
    
}
