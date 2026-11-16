# Portfolio assets

This folder is a local asset library. Local paths are not permanent public URLs: publish these files to your website, a public repository, or storage with stable URLs before linking to them online. Keep filenames unchanged when replacing an asset to preserve its published URL.

## Personal assets

- `resume/Mukesh_Varma_Data_Engineer_Resume.pdf`: current resume.
- `resume/archive/`: optional dated resume backups.
- `education/`: education documents and institution logos.
- `profile/`: add `avatar-linkedin.jpg` (600 x 600), `avatar-casual.jpg`, `hero-banner.webp` (1920 x 600), and `hero-banner-mobile.webp` (800 x 1000).
- `certifications/`: add your actual certificate PDFs and verified badges; payment confirmations are not certificates.

## Website assets

- `logos/tools/`: white rectangular SVG tiles for a scrolling skills strip.
- `logos/companies/`: company logos for your experience page.
- `projects/`: project architecture diagrams and space for project covers and case studies.
- `insights/`: add article cover images.

## Brand and usage notes

Third-party logos are trademarks of their respective owners. Check each owner's brand guidelines before public use; a logo does not imply endorsement. Simple Icons provides brand icons under CC0, subject to its [legal disclaimer](https://github.com/simple-icons/simple-icons/blob/develop/DISCLAIMER.md). Other sources and missing assets are listed below.

## Local index

- [Resume](resume/Mukesh_Varma_Data_Engineer_Resume.pdf)
- [Graduation certificate](education/graduation-certificate.pdf)
- [Supply chain lakehouse diagram](projects/supply-chain-lakehouse/architecture.svg)
- [Stock intelligence pipeline diagram](projects/stock-intelligence-pipeline/architecture.svg)
- [Tool logo tiles](logos/tools/)
- [Stryker company logo](logos/companies/stryker.png)

Both architecture diagrams are illustrative, not evidence of an implemented design. Edit them to match your actual projects. The graduation certificate and resume may contain personal information: review them before publishing.

## Logo sources

Each skill tile is 224 x 64 with a white background, an icon, and a label. The source URLs for individual icons are in [build-assets.ps1](build-assets.ps1); most are served by [Iconify](https://icon-sets.iconify.design/) from the Logos, Devicon, The SVG, and Material Symbols collections. Delta Lake artwork is from the [Delta Lake project](https://github.com/delta-io/delta/blob/master/docs/src/assets/delta-lake-logo-light.svg). Power Apps and Power Automate artwork comes from [Microsoft's Power Platform icon pack](https://learn.microsoft.com/en-us/power-platform/guidance/icons); Microsoft limits those icons to architecture diagrams, training, or documentation unless additional permission is granted, so confirm permission before using them in a website logo marquee.

Unity Catalog uses the Databricks company mark, not a Unity Catalog-specific mark. SSIS uses the SQL Server mark, and SQL uses a generic SQL symbol; neither is represented as a product-specific logo. The tiles include added backgrounds and labels, so check the trademark owner's rules for modified presentations.

The Stryker company logo is derived from [Stryker's website](https://www.stryker.com/etc/designs/stryker/images/header/logo.png), with its white background removed to make it transparent. Check Stryker's brand rules before using it publicly.

## Still needed

- Your profile photos, desktop/mobile hero banners, project covers, case study, and article covers.
- Actual DP-750 and Databricks certificates and verified badges, if earned.
- Your institution's education logo.
- A public hosting URL for each asset you choose to publish. Do not publish private documents unintentionally.

The optional builder skips files that already exist, so it will not overwrite your replacements. It requires network access and Windows PowerShell; execution policies may prevent running it.