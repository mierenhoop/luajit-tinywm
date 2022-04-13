local ffi = require "ffi"

ffi.cdef [[
typedef struct _XDisplay Display;

typedef unsigned long XID;
typedef XID Window;

typedef int Bool;

typedef char *XPointer;

typedef struct _XExtData {
	int number;		/* number returned by XRegisterExtension */
	struct _XExtData *next;	/* next item on list of data for structure */
	int (*free_private)(	/* called to free private storage */
	struct _XExtData *extension
	);
	XPointer private_data;	/* data private to this extension. */
} XExtData;

typedef unsigned long VisualID;

typedef struct {
	XExtData *ext_data;	/* hook for extension to hang data */
	VisualID visualid;	/* visual id of this visual */
	int class;		/* class of screen (monochrome, etc.) */
	unsigned long red_mask, green_mask, blue_mask;	/* mask values */
	int bits_per_rgb;	/* log base 2 of distinct color values */
	int map_entries;	/* color map entries */
} Visual;

typedef XID Colormap;


typedef struct {
	int depth;		/* this depth (Z) of the depth */
	int nvisuals;		/* number of Visual types at this depth */
	Visual *visuals;	/* list of visuals possible at this depth */
} Depth;

typedef struct _XGC *GC;

typedef struct {
	XExtData *ext_data;	/* hook for extension to hang data */
	struct _XDisplay *display;/* back pointer to display structure */
	Window root;		/* Root window id. */
	int width, height;	/* width and height of screen */
	int mwidth, mheight;	/* width and height of  in millimeters */
	int ndepths;		/* number of depths possible */
	Depth *depths;		/* list of allowable depths on the screen */
	int root_depth;		/* bits per pixel */
	Visual *root_visual;	/* root visual */
	GC default_gc;		/* GC for the root root visual */
	Colormap cmap;		/* default color map */
	unsigned long white_pixel;
	unsigned long black_pixel;	/* White and Black pixel values */
	int max_maps, min_maps;	/* max and min color maps */
	int backing_store;	/* Never, WhenMapped, Always */
	Bool save_unders;
	long root_input_mask;	/* initial root input mask */
} Screen;

typedef struct {
    int x, y;			/* location of window */
    int width, height;		/* width and height of window */
    int border_width;		/* border width of window */
    int depth;          	/* depth of window */
    Visual *visual;		/* the associated visual structure */
    Window root;        	/* root of screen containing window */
    int class;			/* InputOutput, InputOnly*/
    int bit_gravity;		/* one of bit gravity values */
    int win_gravity;		/* one of the window gravity values */
    int backing_store;		/* NotUseful, WhenMapped, Always */
    unsigned long backing_planes;/* planes to be preserved if possible */
    unsigned long backing_pixel;/* value to be used when restoring planes */
    Bool save_under;		/* boolean, should bits under be saved? */
    Colormap colormap;		/* color map to be associated with window */
    Bool map_installed;		/* boolean, is color map currently installed*/
    int map_state;		/* IsUnmapped, IsUnviewable, IsViewable */
    long all_event_masks;	/* set of events all people have interest in*/
    long your_event_mask;	/* my event mask */
    long do_not_propagate_mask; /* set of events that should not propagate */
    Bool override_redirect;	/* boolean value for override-redirect */
    Screen *screen;		/* back pointer to correct screen */
} XWindowAttributes;

typedef unsigned long Time;

typedef struct {
	int type;		/* of event */
	unsigned long serial;	/* # of last request processed by server */
	Bool send_event;	/* true if this came from a SendEvent request */
	Display *display;	/* Display the event was read from */
	Window window;	        /* "event" window it is reported relative to */
	Window root;	        /* root window that the event occurred on */
	Window subwindow;	/* child window */
	Time time;		/* milliseconds */
	int x, y;		/* pointer x, y coordinates in event window */
	int x_root, y_root;	/* coordinates relative to root */
	unsigned int state;	/* key or button mask */
	unsigned int button;	/* detail */
	Bool same_screen;	/* same screen flag */
} XButtonEvent;


typedef struct {
	int type;		/* of event */
	unsigned long serial;	/* # of last request processed by server */
	Bool send_event;	/* true if this came from a SendEvent request */
	Display *display;	/* Display the event was read from */
	Window window;	        /* "event" window it is reported relative to */
	Window root;	        /* root window that the event occurred on */
	Window subwindow;	/* child window */
	Time time;		/* milliseconds */
	int x, y;		/* pointer x, y coordinates in event window */
	int x_root, y_root;	/* coordinates relative to root */
	unsigned int state;	/* key or button mask */
	unsigned int keycode;	/* detail */
	Bool same_screen;	/* same screen flag */
} XKeyEvent;

typedef struct {
	int type;		/* of event */
	unsigned long serial;	/* # of last request processed by server */
	Bool send_event;	/* true if this came from a SendEvent request */
	Display *display;	/* Display the event was read from */
	Window window;	        /* "event" window reported relative to */
	Window root;	        /* root window that the event occurred on */
	Window subwindow;	/* child window */
	Time time;		/* milliseconds */
	int x, y;		/* pointer x, y coordinates in event window */
	int x_root, y_root;	/* coordinates relative to root */
	unsigned int state;	/* key or button mask */
	char is_hint;		/* detail */
	Bool same_screen;	/* same screen flag */
} XMotionEvent;

typedef union _XEvent {
    int type;
    XKeyEvent xkey;
    XButtonEvent xbutton;
    long pad[24];
} XEvent;

Display *XOpenDisplay(const char *display_name);

Window XDefaultRootWindow(Display *display);

int XGrabKey(Display  *display,  int keycode, unsigned int modifiers, Window grab_window, Bool owner_events,  int  pointer_mode,  int keyboard_mode);

typedef unsigned char KeyCode;
typedef XID KeySym;

KeyCode XKeysymToKeycode(Display *display, KeySym keysym);

KeySym XStringToKeysym(const char *string);

typedef XID Cursor;

int  XGrabButton(Display  *display,  unsigned int button, unsigned int modifiers, Window grab_window, Bool owner_events, unsigned  int event_mask, int pointer_mode, int keyboard_mode, Window confine_to, Cursor cursor);

int XNextEvent(Display *display, XEvent *event_return);

int XRaiseWindow(Display *display, Window w);


int XGrabPointer(Display   *display,   Window   grab_window,    Bool owner_events,  unsigned  int  event_mask, int pointer_mode, int keyboard_mode, Window confine_to, Cursor cursor, Time time);

typedef int Status;

Status XGetWindowAttributes(Display  *display,  Window  w,  XWindowAttributes *window_attributes_return);

Bool XCheckTypedEvent(Display *display, int event_type, XEvent *event_return);


int XMoveResizeWindow(Display *display, Window w, int x, int y, unsigned width, unsigned height);


int XUngrabPointer(Display *display, Time time);
]]

Mod1Mask = bit.lshift(1, 3)
GrabModeAsync = 1
ButtonPressMask = bit.lshift(1, 2)
ButtonReleaseMask = bit.lshift(1, 3)
ButtonPress = 4
ButtonRelease = 5
KeyPress = 2
PointerMotionMask = bit.lshift(1, 6)
CurrentTime = 0
MotionNotify = 6

local X = ffi.load "X11"

local dpy = X.XOpenDisplay(nil)
if not dpy then error"cannot open display" end

local root = X.XDefaultRootWindow(dpy)

X.XGrabKey(dpy, X.XKeysymToKeycode(dpy, X.XStringToKeysym("F1")), Mod1Mask, root, 1, GrabModeAsync, GrabModeAsync)
X.XGrabButton(dpy, 1, Mod1Mask, root, 1, ButtonPressMask, GrabModeAsync, GrabModeAsync, 0, 0)
X.XGrabButton(dpy, 3, Mod1Mask, root, 1, ButtonPressMask, GrabModeAsync, GrabModeAsync, 0, 0)

local start

local attr = ffi.new"XWindowAttributes[1]"

local evn = ffi.new"XEvent[1]"

while true do
    X.XNextEvent(dpy, evn)
    local ev = evn[0]

    if ev.type == KeyPress and ev.xkey.subwindow ~= 0 then
        X.XRaiseWindow(dpy, ev.xkey.subwindow)
    elseif ev.type == ButtonPress and ev.xbutton.subwindow ~= 0 then
        X.XGrabPointer(dpy, ev.xbutton.subwindow, 1, bit.bor(PointerMotionMask,ButtonReleaseMask), GrabModeAsync, GrabModeAsync, 0, 0, CurrentTime)

        X.XGetWindowAttributes(dpy, ev.xbutton.subwindow, attr)
        start = ev.xbutton;
    elseif ev.type == MotionNotify then
        while X.XCheckTypedEvent(dpy, MotionNotify, evn) ~= 0 do end

        local ev = evn[0]

        local xdiff = ev.xbutton.x_root - start.x_root
        local ydiff = ev.xbutton.y_root - start.y_root

        X.XMoveResizeWindow(dpy, ev.xmotion.window,
                attr.x + (start.button==1 and xdiff or 0),
                attr.y + (start.button==1 and ydiff or 0),
                math.max(1, attr.width + (start.button==3 and xdiff or 0)),
                math.max(1, attr.height + (start.button==3 and ydiff or 0)))
    elseif ev.type == ButtonRelease then
        X.XUngrabPointer(dpy, CurrentTime)
    end
end
