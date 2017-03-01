# Kinopoisk Review Analysis

**KPRA** is an experimental service to reduce tons of letters in film reviews
to quicklier grasp the films' essence and answer the two questions:

- Why _should_ I watch the film?
- Why should _not_ I watch the film?

## Development Process Outline

- [ ] Find the location (in HTML) of the numbers that indicate how many
positive/negative/neutral reviews there are, and extract them.
- [ ] Depending of the above numbers, calculate the maximum number of reviews
per page to display (in order to minimize the number of pages to download and
parse).
- [ ] Write a script to download all the reviews (and, perhaps, store them
temporary locally).
- [ ] Compute the `tf–idf` statistic on the obtained data (together and
separately for different moods).

  > The characteristic considers a single review as a _document_, and the
  entire list of the reviews pertaining to one of the moods as a _corpus_.
- [ ] Define collocations by using different metrics (`t-test`, `chi-square`,
`MLE`, `MI`/`PMI`, etc.)
- [ ] Develop a simple GUI for a web service.

## Plans For the Future

* KPRA should function as a separate web service that enables users to promptly
check the info about the film.
* KPRA should somehow retain the already collected information for the quicker
processing of further requests.
