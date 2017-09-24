/*
 * Copyright (C) 2013 Tomasz Olszak <olszak.tomasz@gmail.com>
 * Copyright (C) 2013 Andrea Bernabei <and.bernabei@gmail.com>
 * Copyright (C) 2017 Eetu Kahelin
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#include "qquicknemocontrolsextensionplugin.h"
#include <QtQml>
#include "hacks.h"
#include "nemowindow.h"
#include "nemopage.h"
#include "qquickfilteringmousearea.h"
#include "nemoimageprovider.h"
#include "sizing.h"
#include "theme.h"
#include "nemofocussingleton.h"

QQuickNemoControlsExtensionPlugin::QQuickNemoControlsExtensionPlugin(QObject *parent) :
    QQmlExtensionPlugin(parent)
{
}

static QObject *nemo_hacks_singletontype_provider(QQmlEngine *engine, QJSEngine */*scriptEngine*/)
{
    QObject *ret = new Hacks(engine);
    return ret;
}
QObject *getNemoFocus(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return NemoFocusSingleton::instance();
}

void QQuickNemoControlsExtensionPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("QtQuick.Controls.Nemo"));
    qmlRegisterSingletonType<QObject>(uri, 1, 0, "NemoFocus", getNemoFocus);
    qmlRegisterSingletonType<QObject>(uri, 1, 0, "NemoHacks", nemo_hacks_singletontype_provider);
    qmlRegisterType<NemoWindow>(uri, 1, 0, "NemoWindow");
    qmlRegisterType<NemoPage>(uri, 1, 0, "NemoPage");
    qmlRegisterType<QQuickFilteringMouseArea>(uri, 1, 0, "FilteringMouseArea");
}

void QQuickNemoControlsExtensionPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Sizing *sizing = new Sizing();
    Theme *theme = new Theme();

    QQmlExtensionPlugin::initializeEngine(engine,uri);
    QQmlContext* context = engine->rootContext();
    context->setContextProperty("size",sizing);
    context->setContextProperty("Theme",theme);

    engine->addImageProvider(QLatin1String("theme"), new NemoImageProvider);
}

