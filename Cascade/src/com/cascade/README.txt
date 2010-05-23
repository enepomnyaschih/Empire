The Cascade library consists of 4 separate parts.

1. cascade.base
The library core. Includes all base files for custom *.css files loading and
custom styles implementation. Provides DOM for CSS-related elements management.

2. cascade.stdparser
Rich standard parsers library. Adds possibility to specify values of some
standard data types as style parameters. Includes integers, strings, floats,
colors, enums etc.
Imports
- cascade.base

3. cascade.visual
Rich standard flex component styles library. Adds possibility to specify
standard flex styles in stylesheet, like backgroundColor, borderStyle etc.
Imports
- cascade.base
- cascade.stdparser

4. cascade.mouse
Includes powerful engine for difficult mouse behaviors implementation.
Provides base classes for custom mouse tools implementation and adds
possibility to specify mouse tools in stylesheet.
Imports
- cascade.base
