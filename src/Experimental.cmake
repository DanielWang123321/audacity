#[[

  Audacity: A Digital Audio Editor

  Experimental.cmake

  Dominic Mazzoni
  James Crook

  Used at configuration time to generate compiler options that enable or disable
  experimental features.

  When the features become mainstream the options will then be retired.

  JKC: This file solves a problem of how to avoid forking the
  code base when working on new features e.g:
    - Additional displays in Audacity
    - Modular architecture.
  Add options in here for the new features, and make your code
  conditional on them with #ifdef.

  For each name in the list, EXPERIMENTAL_{name} is the token to test with
  #ifdef.

  All the options are positive, i.e., when not commented out,
  they enable the feature.

]]

set( EXPERIMENTAL_OPTIONS_LIST
   # ACH 08 Jan 2014
   # EQ accelerated code
   #EQ_SSE_THREADED

   # JKC an experiment to work around bug 2709
   # disabled.
   #CEE_NUMBERS_OPTION

   # Define this so that sync-lock tiles shine through spectrogram.
   # The spectrogram pastes a bitmap over the tiles.
   # This makes it use alpha blending, most transparent where least intense.
   #SPECTROGRAM_OVERLAY

   #August 2009 - Theming not locked down enough for a stable release.
   # This turns on the Theme panel in Prefs dialog.
   #THEME_PREFS

   #ROLL_UP_DIALOG
   #RIGHT_ALIGNED_TEXTBOXES
   #VOICE_DETECTION

   # Andreas Micheler, 20.Nov 2007:
   # A spectrumLogF-like view mode with notes quantization.
   # Just select the "Find Notes" checkbox in the spectrum prefs
   # to activate it instead of the Spectrum log(f) mode.
   #FIND_NOTES

   # AM, 22.Nov 2007:
   # A Frequency Grid for the Spectrum Log(f) & Find Notes modes
   #FFT_Y_GRID

   # Andy Coder, 03.Mar 2009:
   # Allow keyboard seeking before initial playback position
   #SEEK_BEHIND_CURSOR

   # Edward Hui 1 Jul 2021
   #BRUSH_TOOL

   # Paul Licameli (PRL) 29 Nov 2014
   #IMPROVED_SEEKING

   #MIDI_IN

   # JKC, 17 Aug 2017
   # Enables the MIDI note stretching feature, which currently
   # a) Is broken on Linux (Bug 1646)
   # b) Crashes with Sync-Lock (Bug 1719)
   # c) Needs UI design review.
   #MIDI_STRETCHING

   # USE_MIDI must be defined in order for SCOREALIGN to work
   #SCOREALIGN

   #Automatically tries to find an acceptable input volume
   #AUTOMATED_INPUT_LEVEL_ADJUSTMENT

   # Define to make the meters look like a row of LEDs
   #METER_LED_STYLE

   # Define to enable the device change handler
   #DEVICE_CHANGE_HANDLER

   # Define for NEW noise reduction effect from Paul Licameli.
   NOISE_REDUCTION

   # Define to enable Nyquist audio clip boundary control (Steve Daulton Dec 2014)
   NYQUIST_SPLIT_CONTROL

   # Paul Licameli (PRL) 16 Apr 2015
   # Support for scrubbing in the AudioIO engine, without calls to it
   SCRUBBING_SUPPORT

   #Define to include crash reporting, if available in wxWidgets build
   #This flag is used only in CrashReport.h; elsewhere use HAS_CRASH_REPORT
   CRASH_REPORT

   # PRL 11 Jul 2017
   # Highlight more things in TrackPanel when the mouse moves over them,
   # using deliberately ugly pens and brushes until there is better cooperation
   # with themes
   #TRACK_PANEL_HIGHLIGHTING

   # Paul Licameli (PRL) 28 Dec 2017
   # Easy drag-and-drop to add Nyquist, LADSPA, and VST plug-ins
   #DRAG_DROP_PLUG_INS

   # PRL 5 Jan 2018
   # Easy change of keystroke bindings for menu items
   #
   # PRL disabled 31 Aug 2021 because, at least on Mac, it misfires the
   # preference dialog whenever any keystroke shortcuts with Shift+ are used
   # EASY_CHANGE_KEY_BINDINGS

   # PRL 1 Jun 2018
   PUNCH_AND_ROLL

   # PRL 31 July 2018
   DRAGGABLE_PLAY_HEAD

   # Poke 13 Nov 2019
   SUBRIP_LABEL_FORMATS
)

# Some more flags that depend on other configuration options

if( "SCRUBBING_SUPPORT" IN_LIST EXPERIMENTAL_OPTIONS_LIST )
   list( APPEND EXPERIMENTAL_OPTIONS_LIST SCRUBBING_SCROLL_WHEEL )
endif()

# Now define the flags
list( TRANSFORM EXPERIMENTAL_OPTIONS_LIST PREPEND "EXPERIMENTAL_"  )
add_compile_definitions( ${EXPERIMENTAL_OPTIONS_LIST} )
