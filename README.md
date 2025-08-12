# calheatmapR

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An R interface for the [cal-heatmap](https://github.com/kamisama/cal-heatmap) JavaScript charting library, which creates **calendar heatmaps to help visualize time series data**, similar to GitHub's contribution graph.

## Overview

`calheatmapR` is an R htmlwidget that wraps the cal-heatmap JavaScript library, enabling you to create interactive calendar-based heatmaps directly from R. These visualizations are perfect for displaying time-series data with temporal patterns, making it easy to spot trends, seasonal variations, and anomalies in your data.

### Key Features

- 📅 **Multiple time domains**: Display data by hour, day, week, month, or year
- 🎨 **Customizable appearance**: Full control over colors, sizes, and layout
- 📊 **Interactive legends**: Built-in legends with customizable ranges
- 🔗 **Shiny integration**: Works seamlessly with Shiny applications
- ⚡ **htmlwidgets foundation**: Leverages the powerful htmlwidgets framework

### Use Cases

- Visualizing daily activity patterns (commits, sales, website traffic)
- Displaying seasonal trends in data
- Creating GitHub-style contribution graphs
- Monitoring KPIs over time with calendar context
- Analyzing temporal patterns in scientific data

## Package Status

This package provides a solid foundation for calendar heatmaps in R. While it implements the core functionality of cal-heatmap, some advanced interactive features (like navigation controls and click events) are not yet available. For a complete list of cal-heatmap features, see the [Methods](https://kamisama.github.io/cal-heatmap/#methods) and [Events](https://kamisama.github.io/cal-heatmap/#events) documentation.

## Credits

This package builds upon the excellent work of:
- The [htmlwidgets](http://www.htmlwidgets.org/) framework by Ramnath Vaidyanathan, JJ Alaire, and the RStudio team
- The [cal-heatmap](https://github.com/kamisama/cal-heatmap) JavaScript library by Wan Qi Chen
- [@timelyportfolio](https://twitter.com/timelyportfolio) for inspiration and extensive htmlwidgets contributions ([buildingwidgets.com](http://www.buildingwidgets.com/))

## Installation

### Prerequisites

Before installing `calheatmapR`, ensure you have:
- R version 3.0.0 or higher
- The `devtools` package for GitHub installation

### Install from GitHub

Since `calheatmapR` is hosted on GitHub, you'll need to install it using `devtools`:

```R
# Install devtools if you haven't already
if (!require(devtools)) {
  install.packages("devtools")
}

# Install calheatmapR from GitHub
devtools::install_github("durtal/calheatmapR")
```

### Load the Package

```R
library(calheatmapR)
library(magrittr)  # For pipe operator %>%
```

## Data Format

`calheatmapR` expects data in a specific format: a **named list** where names are timestamps (in seconds since Unix epoch) and values are numeric measurements.

### Understanding Timestamps

The cal-heatmap library uses timestamps in seconds (not milliseconds). Here's how to work with them in R:

```R
# Convert dates to timestamps
date_string <- "2023-01-01"
timestamp <- as.numeric(as.POSIXct(date_string))
print(timestamp)
# [1] 1672531200

# Convert timestamps back to dates (for verification)
as.POSIXct(timestamp, origin = "1970-01-01")
# [1] "2023-01-01 UTC"
```

### Creating Data

Here are different ways to create properly formatted data:

#### Example 1: Simple Sequential Data

```R
# Create data for three consecutive days
dates <- c("2023-01-01", "2023-01-02", "2023-01-03")
values <- c(1, 10, 100)

# Convert to timestamps and create named list
timestamps <- as.numeric(as.POSIXct(dates))
data <- as.list(values)
names(data) <- timestamps

# View the structure
str(data)
# List of 3
#  $ 1672531200: num 1
#  $ 1672617600: num 10
#  $ 1672704000: num 100
```

#### Example 2: Real-world Time Series

```R
# Generate sample data for a month
start_date <- as.Date("2023-01-01")
dates <- start_date + 0:30  # 31 days
values <- round(runif(31, 0, 100), 1)  # Random values 0-100

# Create properly formatted data
timestamps <- as.numeric(as.POSIXct(dates))
sample_data <- as.list(values)
names(sample_data) <- timestamps
```

#### Example 3: Working with Existing Data Frames

```R
# Assuming you have a data frame with date and value columns
df <- data.frame(
  date = seq(as.Date("2023-01-01"), as.Date("2023-01-31"), by = "day"),
  value = runif(31, 0, 100)
)

# Convert to calheatmapR format
timestamps <- as.numeric(as.POSIXct(df$date))
cal_data <- as.list(df$value)
names(cal_data) <- timestamps
```

## Quick Start

### Basic Usage

The simplest way to create a calendar heatmap:

```R
# Create sample data
dates <- c("2023-01-01", "2023-01-02", "2023-01-03")
values <- c(25, 50, 75)
timestamps <- as.numeric(as.POSIXct(dates))
demo_data <- as.list(values)
names(demo_data) <- timestamps

# Create basic heatmap
calheatmapR(data = demo_data)
```

This creates a default calendar heatmap showing values per minute for 12 hours.

### Customizing Your Heatmap

The real power of `calheatmapR` comes from customization using the pipe operator and configuration functions:

#### Setting Time Domains

```R
# Display days within months, starting December 2023, for 6 months
calheatmapR(data = demo_data) %>%
  chDomain(
    domain = "month",      # Main time unit
    subDomain = "day",     # Sub time unit
    start = "2023-12-01",  # Start date
    range = 6              # Number of months to show
  )
```

#### Adding a Legend

```R
calheatmapR(data = demo_data) %>%
  chDomain(domain = "month", subDomain = "day", start = "2023-01-01", range = 3) %>%
  chLegend(
    legend = c(10, 25, 50, 75),    # Value thresholds
    colours = c("#d6e685", "#8cc665", "#44a340", "#1e6823")  # GitHub-style colors
  )
```

#### Customizing Labels

```R
calheatmapR(data = demo_data) %>%
  chDomain(domain = "month", subDomain = "day", start = "2023-01-01", range = 3) %>%
  chLegend(legend = c(10, 25, 50, 75)) %>%
  chLabel(
    position = "bottom",
    itemName = c("contribution", "contributions")
  )
```

## Complete Examples

### Example 1: GitHub-Style Contribution Graph

```R
# Generate year-long sample data
start_date <- as.Date("2023-01-01")
end_date <- as.Date("2023-12-31")
all_dates <- seq(start_date, end_date, by = "day")

# Simulate contribution data (0-20 commits per day)
set.seed(42)  # For reproducible results
contributions <- rpois(length(all_dates), lambda = 3)

# Format for calheatmapR
timestamps <- as.numeric(as.POSIXct(all_dates))
contrib_data <- as.list(contributions)
names(contrib_data) <- timestamps

# Create GitHub-style heatmap
calheatmapR(data = contrib_data) %>%
  chDomain(
    domain = "month",
    subDomain = "day", 
    start = "2023-01-01",
    range = 12,
    cellSize = 12,
    cellPadding = 2
  ) %>%
  chLegend(
    legend = c(1, 5, 10, 15),
    colours = list(
      min = "#eee",
      max = "#196127",
      empty = "#f0f0f0"
    ),
    display = TRUE
  ) %>%
  chLabel(
    position = "bottom",
    itemName = c("contribution", "contributions")
  )
```

### Example 2: Business Metrics Dashboard

```R
# Sample sales data
sales_dates <- seq(as.Date("2023-10-01"), as.Date("2023-12-31"), by = "day")
daily_sales <- round(rnorm(length(sales_dates), mean = 1000, sd = 300), 0)
daily_sales[daily_sales < 0] <- 0  # No negative sales

# Format data
sales_timestamps <- as.numeric(as.POSIXct(sales_dates))
sales_data <- as.list(daily_sales)
names(sales_data) <- sales_timestamps

# Create business-oriented heatmap
calheatmapR(data = sales_data) %>%
  chDomain(
    domain = "month",
    subDomain = "day",
    start = "2023-10-01",
    range = 3,
    cellSize = 15
  ) %>%
  chLegend(
    legend = c(500, 1000, 1500, 2000),
    colours = c("#feedde", "#fdd0a2", "#fd8d3c", "#d94801"),
    display = TRUE
  ) %>%
  chLabel(
    position = "top",
    itemName = c("dollar", "dollars")
  )
```

### Example 3: Using Real Data (Todd Pletcher Example)

The package includes sample data about racehorse trainer Todd Pletcher:

```R
# Load the included sample data
data(pletcher)

# View the data structure
str(pletcher)
head(names(pletcher))
head(unlist(pletcher))

# Create heatmap with the sample data
calheatmapR(data = pletcher) %>%
  chDomain(
    domain = "month",
    subDomain = "day",
    range = 3
  ) %>%
  chLegend(
    legend = c(25, 50, 75, 100),
    display = TRUE
  )
```

## API Reference

### Core Functions

#### `calheatmapR(data, width = NULL, height = NULL)`
Creates the main calendar heatmap widget.

**Parameters:**
- `data`: Named list where names are timestamps (seconds) and values are numeric
- `width`: Width of the widget (optional)
- `height`: Height of the widget (optional)

#### `chDomain(calheatmapR, ...)`
Configures time domains and display options.

**Key Parameters:**
- `domain`: Main time unit (`"hour"`, `"day"`, `"week"`, `"month"`, `"year"`)
- `subDomain`: Sub time unit (must be smaller than domain)
- `start`: Start date in `"YYYY-MM-DD"` format
- `range`: Number of domains to display
- `cellSize`: Size of each cell in pixels
- `cellPadding`: Space between cells in pixels

#### `chLegend(calheatmapR, ...)`
Configures the legend appearance and behavior.

**Key Parameters:**
- `legend`: Numeric vector defining value ranges
- `colours`: Color scheme (vector or list with min/max)
- `display`: Whether to show legend (`TRUE`/`FALSE`)
- `cellSize`: Legend cell size in pixels

#### `chLabel(calheatmapR, ...)`
Configures labels and tooltips.

**Key Parameters:**
- `position`: Label position (`"bottom"`, `"left"`, `"top"`, `"right"`)
- `itemName`: Singular and plural forms of the data unit

### Shiny Integration

`calheatmapR` works seamlessly with Shiny applications:

```R
library(shiny)
library(calheatmapR)

# UI
ui <- fluidPage(
  titlePanel("Calendar Heatmap in Shiny"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("intensity", "Data Intensity:", 
                  min = 1, max = 10, value = 5),
      actionButton("generate", "Generate New Data")
    ),
    
    mainPanel(
      calheatmapROutput("heatmap", height = "400px")
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # Reactive data generation
  heatmap_data <- eventReactive(input$generate, {
    dates <- seq(as.Date("2023-01-01"), as.Date("2023-03-31"), by = "day")
    values <- rpois(length(dates), lambda = input$intensity)
    
    timestamps <- as.numeric(as.POSIXct(dates))
    data <- as.list(values)
    names(data) <- timestamps
    
    return(data)
  }, ignoreNULL = FALSE)
  
  # Render heatmap
  output$heatmap <- renderCalheatmapR({
    calheatmapR(data = heatmap_data()) %>%
      chDomain(domain = "month", subDomain = "day", 
               start = "2023-01-01", range = 3) %>%
      chLegend(legend = c(1, 3, 5, 8))
  })
}

# Run the app
shinyApp(ui = ui, server = server)
```

## Domain and SubDomain Combinations

Valid combinations of domain and subDomain:

| Domain | Valid SubDomains |
|--------|------------------|
| `hour` | `min`, `x_min` |
| `day` | `hour`, `x_hour` |
| `week` | `day`, `x_day` |
| `month` | `day`, `x_day`, `week`, `x_week` |
| `year` | `month`, `x_month`, `week`, `x_week`, `day`, `x_day` |

**Note:** The `x_` prefix creates alternative layouts for the subdomain.

## Troubleshooting

### Common Issues

#### "Data not displaying correctly"
- **Check timestamp format**: Ensure timestamps are in seconds, not milliseconds
- **Verify data structure**: Data should be a named list with numeric values
- **Check date range**: Ensure your start date aligns with your data

```R
# Debug your timestamps
timestamps <- as.numeric(as.POSIXct(c("2023-01-01", "2023-01-02")))
print(timestamps)
# Should show large numbers like: 1672531200 1672617600

# Verify data structure
str(your_data)
# Should show: List of X, with named elements
```

#### "Empty heatmap displayed"
- **Domain/SubDomain mismatch**: Check that your date range matches the domain settings
- **Missing data for time period**: Ensure you have data for the displayed time range

#### "Legend not showing"
- **Set display = TRUE**: Make sure `chLegend(display = TRUE)`
- **Check legend values**: Ensure legend thresholds make sense for your data range

#### "Shiny integration issues"
- **Use reactive data**: Wrap data generation in `reactive()` or `eventReactive()`
- **Proper render function**: Use `renderCalheatmapR()` not `renderPlot()`

### Getting Help

1. **Check the documentation**: Use `?calheatmapR`, `?chDomain`, etc.
2. **cal-heatmap documentation**: Visit [https://kamisama.github.io/cal-heatmap/](https://kamisama.github.io/cal-heatmap/)
3. **GitHub issues**: Report bugs at [https://github.com/durtal/calheatmapR/issues](https://github.com/durtal/calheatmapR/issues)

## Contributing

Contributions are welcome! Here's how you can help:

1. **Report bugs**: Open an issue with a reproducible example
2. **Suggest features**: Propose new functionality via issues
3. **Submit pull requests**: Fix bugs or add features
4. **Improve documentation**: Help make the documentation clearer

### Development Setup

```R
# Clone the repository
# git clone https://github.com/durtal/calheatmapR.git

# Install development dependencies
devtools::install_deps(dependencies = TRUE)

# Build and check the package
devtools::check()
```

## License

This package is released under the MIT License. See the [LICENSE](LICENSE) file for details.

---

**Note**: This package wraps the cal-heatmap JavaScript library. Some advanced interactive features from the original library are not yet implemented in this R interface. If you need specific functionality, please open an issue or consider contributing!
