//
//  DropAreaView.swift
//  Sblack
//
//  Created by Francesco Di Lorenzo on 04/02/2018.
//  Copyright © 2018 Francesco Di Lorenzo. All rights reserved.
//

import Foundation
import AppKit

typealias Interaction = () -> Void
typealias InteractionWithURL = (URL) -> Void

class DropAreaView: NSView {
    
    var dragDidStart: Interaction?
    var dragDidCancel: Interaction?
    var dragDidEnd: InteractionWithURL?
    
    override init(frame: NSRect = .zero) {
        super.init(frame: frame)
        self.setup()
        self.autolayout()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.setup()
        self.autolayout()
    }
    
    func setup() {
        if #available(OSX 10.13, *) {
            self.registerForDraggedTypes([NSPasteboard.PasteboardType.URL])
        } else {
            self.registerForDraggedTypes([NSPasteboard.PasteboardType(kUTTypeURL as String)])
        }
    }
    
    func autolayout() {
        
    }
        
    // MARK: NSDragDestination
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        self.dragDidStart?()
        return .copy
    }
        
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.dragDidCancel?()
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pboard = sender.draggingPasteboard()
        let fileURL: URL! = NSURL(from: pboard) as URL!
        
        self.dragDidEnd?(fileURL)
        
        return true
    }
}
