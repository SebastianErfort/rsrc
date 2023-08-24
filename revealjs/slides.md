# Markdown Presentations

Since `0.19.0`, Zettlr supports exporting presentations using both the `reveal.js`-framework and `pandoc`.

***

## MD + Zettlr + `reveal.js` = ❤️

Creating presentations using Zettlr is simple: Each slide is begun by a header level 1. Any text afterwards will become the slide's content.

***

But using a line divider ("`***`" or `---`) is also permitted. This lets you have more space on your slide.

***

## Smaller headings

This can also be used to make headings smaller, if you don't like the big level-1-headings.

***

## Control the presentation

You can control the presentation with the keyboard:

- `F` enters the fullscreen
- `.` blacks out the slide
- `?` shows additional shortcuts.

***

## Markdown elements

All elements that you might use in markdown are permitted in these slides as well.

|               | Had Coffee? | Mood |
|---------------|-------------|------|
| Participant A |         Yes | 0.97 |
| Participant B |         Yes | 0.46 |
| Participant C |          No | 0.47 |

***

## Advanced options

Use the `.fragment`-class to add effects and transitions to elements.

<ul>
    <li class="fragment fade-in">This item will fade in.</li>
    <li class="fragment highlight-blue">This will be highlighted blue.</li>
    <li class="fragment highlight-red">All available transitions are documented [here](https://github.com/hakimel/reveal.js/#fragments).</li>
</ul>

***

## `reveal.js` Settings

You can change the settings of the slideshow in the presentation file. Open it in any text editor and search for the comment sections (search for lines of "`*`"-characters).

In the first section you can alter the behaviour of `reveal.js`. It is documented well. In the second you can alter the styling of the presentation, for instance make the background dark and colour light.

***

## `reveal.js` Settings

The options look like this. They should be self-explanatory.

```javascript
const zettlrRevealOptions = {
    // Display controls in the bottom right corner
    controls: false,
    // Display a presentation progress bar
    progress: true,
    // ...
	};
```
***

## `reveal.js` Settings

The styling can be changed like this:

```css
body {
    background-color:rgb(40, 40, 40);
    color: rgb(200, 200, 220);
}

.reveal, .reveal h1, .reveal h2 {
    color: rgb(200, 200, 220);
}
```

***

## Benefits of `reveal.js`

Why not use PowerPoint? Because …

* … `HTML` runs **on every computer**.
* … `reveal.js` is lightweight.
* … it's future-proof.
* … the presentations can be shared everywhere.

***

## Drawbacks

Yet, there are two important drawbacks:

* Images are not embedded in the resulting file.
* Changing the appearance requires knowledge of CSS.

***

## Conclusion

* Draw attention to your lectures using modern presentations easily written in Zettlr!
* Never again fear whether or not the location has the right software installed on their computers!

<hr>

<small>If you want to learn more, check out the Markdown file that was used to create this presentation [here](https://www.zettlr.com/themes/zettlr/assets/slides.md)!</small>