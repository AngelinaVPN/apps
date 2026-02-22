import AppKit
import Cocoa
import FlutterMacOS

class PopoverContainerViewController: NSViewController {
    let flutterViewController: FlutterViewController
    
    init(flutterViewController: FlutterViewController) {
        self.flutterViewController = flutterViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 620, height: 860))
                
        addChild(flutterViewController)
        flutterViewController.view.frame = self.view.bounds
        flutterViewController.view.autoresizingMask = [.width, .height]
        self.view.addSubview(flutterViewController.view)
    }
}

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    private var contextMenu: NSMenu?
    
    init(_ popover: NSPopover) {
        self.popover = popover
        statusBar = NSStatusBar.system
        statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        configureStatusItemButton()
        setupContextMenu()
    }

    private func configureStatusItemButton() {
        statusItem.isVisible = true
        guard let statusBarButton = statusItem.button else {
            NSLog("StatusBarController: ERROR - Could not get status bar button!")
            return
        }

        statusBarButton.imagePosition = .imageOnly
        statusBarButton.title = ""
        statusBarButton.image = nil

        if let icon = statusIconImage() {
            statusBarButton.image = icon
            statusBarButton.image?.isTemplate = false
        } else {
            // Final fallback so item is still visible.
            statusBarButton.title = "A"
        }

        statusBarButton.action = #selector(togglePopover(sender:))
        statusBarButton.target = self
        statusBarButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
    
    private func setupContextMenu() {
        let menu = NSMenu()
        
        let quitItem = NSMenuItem(
            title: "Quit AngelinaVPN",
            action: #selector(quitApp),
            keyEquivalent: "q"
        )
        quitItem.target = self
        menu.addItem(quitItem)
        
        contextMenu = menu
        NSLog("StatusBarController: Context menu created")
    }
    
    @objc func togglePopover(sender: AnyObject) {
        if let event = NSApp.currentEvent {
            if event.type == .rightMouseUp {
                showContextMenu()
                return
            }
        }
        
        if(popover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }
    
    private func showContextMenu() {
        if let menu = contextMenu, let button = statusItem.button {
            statusItem.menu = menu
            button.performClick(nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.statusItem.menu = nil
            }
        }
    }
    
    @objc func quitApp() {
        NSLog("StatusBarController: Quit requested")
        NSApplication.shared.terminate(nil)
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
            popover.contentViewController?.view.window?.makeKey()
        }
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
    
    func updateIcon(isVpnConnected: Bool) {
        if let button = statusItem.button {
            button.toolTip = isVpnConnected ? "AngelinaVPN: connected" : "AngelinaVPN: disconnected"
            if let icon = statusIconImage() {
                button.image = icon
                button.image?.isTemplate = false
            }
        }
    }

    func ensureVisible() {
        if statusItem.button == nil {
            statusBar.removeStatusItem(statusItem)
            statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
            configureStatusItemButton()
            return
        }
        statusItem.isVisible = true
        if let button = statusItem.button, button.image == nil, button.title.isEmpty {
            configureStatusItemButton()
        }
    }
   
    func destroy() {
        hidePopover(self as AnyObject)
        statusBar.removeStatusItem(statusItem)
    }

    private func statusIconImage() -> NSImage? {
        guard let appIcon = NSApp.applicationIconImage.copy() as? NSImage else {
            return nil
        }
        appIcon.size = NSSize(width: 18, height: 18)
        return appIcon
    }

}
